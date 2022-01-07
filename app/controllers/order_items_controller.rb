class OrderItemsController < ApplicationController
  before_action :set_order_item, except: [:new, :create, :index]

  def create
    @current_order.order_items.build(order_item_params)
    if @current_order.save
      session[:order_id] = @current_order.id
      sneaker = Sneaker.find(order_item_params[:sneaker_id])
      flash[:notice] = "#{sneaker.name} has been added to cart"
      location = session[:previous_path] || sneakers_path
      redirect_to location
    elsif order_item_is_not_in_order?
      flash[:alert] = "#{sneaker.name.capitalize} is already in cart"
      redirect_back(fallback_location: sneakers_path)
    else
      flash[:alert] = 'Something went wrong'
      redirect_back(fallback_location: sneakers_path)
    end
  end

  def update
    if @order_item.update(quantity: order_item_params[:quantity])
      flash[:notice] = "#{order_item.sneaker.name} has been updated in cart"
      location = session[:previous_path] || sneakers_path
      redirect_to location
    else
      flash[:alert] = 'Something went wrong'
      redirect_back(fallback_location: sneakers_path)
    end
  end

  def destroy
    @order_item.destroy
    location = session[:previous_path] || sneakers_path
    redirect_to location
  end

  private
  def order_item_params
    params.permit(:sneaker_id, :quantity)
  end

  def set_order_item
    @order_item = Order.find(params[:id])
  end

  def order_item_is_not_in_order?
    sneaker = @current_order
                .order_items
                .where(':sneaker_id = ?', order_items_params[:sneaker_id])
                .take
    !!sneaker
  end
end
