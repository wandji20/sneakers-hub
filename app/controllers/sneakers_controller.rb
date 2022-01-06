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
    records = records.joins(:brand).where(brand: { name: params[:brand] }) if params[:brand]
    records = records.joins(:gender).where(gender: { name: params[:gender] }) if params[:gender]
    records = records.send(params['sort-by']) if params['sort-by']
    records
  end
end
