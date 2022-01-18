class OrdersController < ApplicationController
  before_action :set_order
  
  def create
    if @order.save
      redirect_to shipping_path(order_id: @order.id)
    else
      flash[:alert] = "Something went wrong"
      redirect_back(fallback_location: root_path)
    end
  end

  def set_order
    if logged_in?
      @order = current_user.orders.new(browser_status: false)
      @order.order_items.build(sneaker_id: params[:sneaker_id])
    else
      @order = Order.new(browser_status: false)
      @order.order_items.build(sneaker_id: params[:sneaker_id])
    end
  end
end
