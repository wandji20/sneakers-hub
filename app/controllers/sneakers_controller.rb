class SneakersController < ApplicationController
  before_action :set_sneaker, only: :show
  before_action :sort_option
  before_action :save_url

  def index
    @pagy, @sneakers = pagy(scoped_records)
    @sneakers.includes(:brand, :gender)

    respond_to do |format|
      format.html
      format.json do
        render json: {
          entries: render_to_string(partial: @sneakers, formats: [:html]), pagination: view_context.pagy_nav(@pagy)
        }
      end
    end
  end

  def show
    @sneaker
  end

  private

  def set_sneaker
    @sneaker = Sneaker.find(params[:id])
  end

  def scoped_records
    records = Sneaker.all
    records = records.joins(:brand).where(brand: { name: params[:brand] }) if params[:brand]
    records = records.joins(:gender).where(gender: { name: params[:gender] }) if params[:gender]
    records = records.send(params['sort-by']) if params['sort-by']
    records
  end

  def sort_option
    sort_options = {
      increasing_price: 'Increasing Price',
      decreasing_price: 'Decreasing Price',
      release_date: 'Release Date'
    }

    @sort_option ||= sort_options[params['sort-by']&.to_sym] || 'All'
  end
end
