class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[stripe_webhook]
  before_action :initialize_order, only: :create

  def create
    @new_order.save!
    # create payment_intent
    payment_intent = StripePayment.create_payment_intent(@new_order.payment_attributes)
    @new_order.update(
      payment_intent_id: payment_intent.id, payment_intent_client_id: payment_intent.client_secret
    )
    handle_update_cart_items(@shopping_cart, params[:sneaker_id])
    redirect_to order_url(@new_order)
  rescue StandardError => e
    p e
    redirect_back(fallback_location: root_path)
    flash[:alert] = 'Something went wrong'
  end

  def show
    @order = Order.find(params[:id])
  end

  def stripe_webhook
    event = set_stripe_event
    # Handle the event
    StripePayment.handle_webhook_response(event)
    head 200
  end

  private

  def initialize_order
    @new_order = if params[:sneaker_id] && logged_in?
                   current_user.orders.build(order_items_attributes: [{ sneaker_id: params[:sneaker_id] }])
                 elsif params[:sneaker_id]
                   Order.new(order_items_attributes: [{ sneaker_id: params[:sneaker_id] }])
                 else
                   Order.new(order_items_attributes: shopping_cart_attributes(@shopping_cart))
                 end
  end

  # rubocop:disable Lint/DuplicateBranch
  def set_stripe_event
    endpoint_secret = ENV['STRIPE_ENDPOINT_SECRET'] || Rails.application.credentials.dig(:stripe, :stripe_endpoint_secret)
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      p e
      # Invalid payload
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      p e
      # Invalid signature
      status 400
      return
    end
    event
  end
  # rubocop:enable Lint/DuplicateBranch

  def handle_update_cart_items(shopping_cart, sneaker_id)
    if shopping_cart.present? && sneaker_id.present? && 
      # filter sneaker_id from shopping cart
      item = shopping_cart.order_items.find_by(sneaker_id:)
      return unless item
      shopping_cart.update(
        order_items: shopping_cart.order_items.where.not(sneaker_id: item.sneaker_id)
      )
    elsif shopping_cart.present?
      # clear shopping cart
      shopping_cart.order_items.destroy_all
    end
  rescue StandardError => e
    p e
  end

  def shopping_cart_attributes(shopping_cart)
    shopping_cart.order_items.pluck(:sneaker_id, :quantity).map do |pair|
      { sneaker_id: pair[0], quantity: pair[1] }
    end
  end
end
