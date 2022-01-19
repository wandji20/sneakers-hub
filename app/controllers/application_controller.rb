class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  
  before_action :load_shopping_cart, :set_brands_and_genders, :load_cart_items

  private

  def paginate(query)
    @pagy, records = pagy(query)
    records
  end

  def load_shopping_cart
    @shopping_cart = if logged_in?
                       current_user.shopping_cart 
                     elsif session[:shopping_cart_id]
                       ShoppingCart.find(session[:shopping_cart_id])   
                     else                     
                       ShoppingCart.new
                     end
  end

  def load_cart_items
    @shopping_cart_items = @shopping_cart.order_items.includes(:sneaker)
    @shopping_cart_items_count = @shopping_cart_items.count
  end

  def set_brands_and_genders
    @brands = Brand.all
    @genders = Gender.all
  end
end
