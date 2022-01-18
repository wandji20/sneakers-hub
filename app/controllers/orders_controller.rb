class OrdersController < ApplicationController
  before_action :initialize_order
  def create
    if @new_order.save
      redirect_to shipping_path(order_id: @new_order.id)
      @shopping_cart.order_items.destroy_all if params[:sneaker_id].nil?
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'Something went wrong'
    end
  end

  private
  def initialize_order
    if params[:sneaker_id] && logged_in?
      @new_order = current_user.orders.build(order_items_attributes: [{ sneaker_id: params[:sneaker_id] }])
    elsif params[:sneaker_id]
      @new_order = Order.new(order_items_attributes: [{ sneaker_id: params[:sneaker_id] }])
    else
      @new_order = Order.new(order_items_attributes: shopping_cart_items)
    end

  end
  
end
