class ApplicationController < ActionController::Base
  before_action :load_order, :set_brands_and_genders, :load_order_items
  include Pagy::Backend

  private

  def paginate(query)
    @pagy, records = pagy(query)
    records
  end

  def load_order
    @current_order = if session[:order_id]
                       Order.find(session[:order_id])
                     else
                       Order.new
                     end
  end

  def load_order_items
    @order_items = @current_order.order_items.includes(:sneaker)
    @order_items_count = @order_items.count
  end

  def save_url
    session[:previous_path] = request.original_fullpath
  end

  def set_brands_and_genders
    @brands = Brand.all
    @genders = Gender.all
  end
end
