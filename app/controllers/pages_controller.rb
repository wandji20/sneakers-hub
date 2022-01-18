class PagesController < ApplicationController
  before_action :save_url
  before_action :set_order, only: :shipping
  
  def home
    @sneakers = Sneaker.release_date.take(10)
  end

  def checkout; end

  def shipping
    @order =  set_order
    p '>>>>>>>>>>>'
    p @order
    p params
  end

  def about; end
  private
  def set_order
    if params[:order_id]
      Order.find_by_id(params[:order_id])
    else
      @current_order
    end
  end
end
