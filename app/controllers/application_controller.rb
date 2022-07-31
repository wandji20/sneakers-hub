class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper

  before_action :shopping_cart, :set_brands_and_genders, :shopping_cart_items

  private

  def paginate(query)
    @pagy, records = pagy(query)
    records
  end

  def shopping_cart
    @shopping_cart ||= if logged_in?
                         ShoppingCart.find_or_create_by(user_id: current_user.id)
                       elsif session[:shopping_cart_id]
                         ShoppingCart.find(session[:shopping_cart_id])
                       else
                         ShoppingCart.new
                       end
  end

  def shopping_cart_items
    @shopping_cart_items ||= @shopping_cart.order_items.includes(:sneaker)
  end

  def set_brands_and_genders
    # @brands = Brand.pluck(:name)
    @brands = Brand.select(:name)
    @genders = Gender.select(:name)
  end
end
