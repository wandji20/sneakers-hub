class SneakersController < ApplicationController
  before_action :set_sneaker, only: :show
  def index
    @brands = Brand.all
    @genders = Gender.all
    @pagy, @sneakers = pagy(Sneaker.all)
    @sneakers.includes(:brand, :gender)
  end

  def show
    @sneaker
  end

  private
  def set_sneaker
    @sneaker = Sneaker.find(params[:id])
  end
end
