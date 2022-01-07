class ApplicationController < ActionController::Base
  before_action :load_order
  include Pagy::Backend

  private

  def paginate(query)
    @pagy, records = pagy(query)
    records
  end

  def load_order
    if session[:order_id]
      @current_order = Order.find(session[:order_id])
    else
      @current_order = Order.new
    end
  end

  def save_url
    session[:previous_path] = request.original_fullpath
  end
end
