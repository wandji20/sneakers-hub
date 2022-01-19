class PagesController < ApplicationController
  before_action :save_url
  before_action :set_order, only: :shipping
  
  def home
    @sneakers = Sneaker.release_date.take(10)
  end

  def checkout
    puts params
  end

  def shipping
  end

  def about; end
  private
  def set_order
    if params[:order_id]
      @order = Order.find_by_id(params[:order_id])
    end
  end
end
