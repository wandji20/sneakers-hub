class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  
  before_action :load_order, :set_brands_and_genders, :load_order_items

  private

  def paginate(query)
    @pagy, records = pagy(query)
    records
  end

  def load_order
    # session.delete(:order_id)
    @current_order = if logged_in?
                       current_user.orders.opened.take  
                     elsif session[:order_id]
                       Order.find(session[:order_id])   
                     else                     
                       Order.new
                     end
  end

  def load_order_items
    @order_items = @current_order.order_items.includes(:sneaker)
    @order_items_count = @order_items.count
  end

  def set_brands_and_genders
    @brands = Brand.all
    @genders = Gender.all
  end
end
