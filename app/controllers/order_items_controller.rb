class OrderItemsController < ApplicationController
  before_action :set_order_item, except: %i[new index create]
  before_action :set_sneaker, only: [:create]
  before_action :verify_order_item, only: :create
  before_action :save_url, only: :index

  def index
    @total = set_order_total
  end

  def create
    @rder_item = @current_order.order_items.build(order_item_params)
    if @current_order.save
      session[:order_id] = @current_order.id
      flash.now[:notice] = "#{@sneaker.name} has been added to cart"
      respond_to do |format|
        format.turbo_stream
      end
    else
      flash.now[:alert] = 'Something went wrong'
      render turbo_stream: turbo_stream.update('alert', partial: 'shared/alert')
    end
  end

  def update
    if @order_item.update(quantity: order_item_params[:quantity])
      flash.now[:notice] = "#{@order_item.sneaker.name} has been updated in cart"
      respond_to do |format|
        format.turbo_stream
      end
    else
      flash.now[:alert] = 'Something went wrong'
      render turbo_stream: [
        turbo_stream.update('alert', partial: 'shared/alert'),
        turbo_stream.update('notice', partial: 'shared/notice')
      ]
    end
  end

  def show; end

  def destroy
    @order_item.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def order_item_params
    params.permit(:sneaker_id, :quantity)
  end

  def set_order_item
    @order_item = @order_items.find_by_id(params[:id])
  end

  def set_sneaker
    @sneaker = Sneaker.find_by_id(order_item_params[:sneaker_id])
  end

  def order_item_is_in_order?
    sneaker = @order_items.where('sneaker_id = ?', order_item_params[:sneaker_id].to_i).take
    !!sneaker
  end

  def verify_order_item
    # rubocop:disable  Style/GuardClause
    if order_item_is_in_order?
      flash.now[:alert] = "#{@sneaker.name.capitalize} is already in cart"
      render turbo_stream: turbo_stream.update('alert', partial: 'shared/alert')
    end
    # rubocop:enable  Style/GuardClause
  end

  def set_order_total
    @order_items.sum(:sub_total)
  end
end
