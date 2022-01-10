class OrderItemsController < ApplicationController
  before_action :set_order_item, except: [:new, :index, :create]
  before_action :set_sneaker, only: [:create]
  before_action :verify_order_item, only: :create
  def index
    @total = set_order_total
  end
  def create
    @current_order.order_items.build(order_item_params)
    if @current_order.save
      session[:order_id] = @current_order.id
      
      flash[:notice] = "#{@sneaker.name} has been added to cart"
      redirect_to @sneaker || root_path
    else
      flash[:alert] = 'Something went wrong'
      redirect_back(fallback_location: @sneakers_path)
    end
  end

  def update
    if @order_item.update(quantity: order_item_params[:quantity])
      flash[:notice] = "#{@order_item.sneaker.name} has been updated in cart"
      redirect_to order_items_path
    else
      flash[:alert] = 'Something went wrong'
      redirect_to order_items_path
    end
  end

  def destroy
    @order_item.destroy
    redirect_to order_items_path
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
    if order_item_is_in_order?
      flash[:alert] = "#{@sneaker.name.capitalize} is already in cart"
      redirect_back(fallback_location: @sneakers_path)
    end
  end

  def set_order_total
    @order_items.sum(:sub_total)
  end
end
