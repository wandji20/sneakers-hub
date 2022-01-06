class SneakersController < ApplicationController
  before_action :set_sneaker, only: :show
  def index
    @brands = Brand.all
    @genders = Gender.all
    @pagy, @sneakers = pagy(scoped_records)
    @sneakers.includes(:brand, :gender)
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
    if params[:brand]
      records = records.joins(:brand).where(brand: {name: params[:brand]})
    end
    if params[:gender]
      records = records.joins(:gender).where(gender: {name: params[:gender]})
    end
    if params['sort-by']
      records = records.send(params['sort-by'])
    end
    records
  end
end
