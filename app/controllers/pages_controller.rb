class PagesController < ApplicationController
  before_action :save_url
  before_action :set_order, only: :shipping

  def home
    @sneakers = Sneaker.release_date.take(10)
  end

  def checkout
    if shipping_params[:order_id] && !shipping_params[:name].strip.empty? && !shipping_params[:email].strip.empty?
      flash[:notice] = 'Your Order is being processed'
      # send_order_emails(shipping_params[:order_id], shipping_params[:email], shipping_params[:name])
      redirect_to root_path
    else
      flash.now[:alert] = 'Please fill all required input fields'
      render turbo_stream: turbo_stream.update('alert', partial: 'shared/alert')
    end
  end

  def shipping; end

  def about; end

  private

  def set_order
    @order = Order.find_by_id(params[:order_id]) if params[:order_id]
  end

  def shipping_params
    params.require(:shipping).permit(:name, :order_id, :email, :street, :city)
  end

  def send_order_emails(order_id, email, name)
    OrderMailer.user_order_email(order_id, email, name).deliver_later
    OrderMailer.ware_house_order_email(order_id, ENV['APP_USERNAME'], name).deliver_later
  end
end
