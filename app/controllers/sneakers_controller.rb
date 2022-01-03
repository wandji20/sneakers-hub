class SneakersController < ApplicationController
  before_action :set_sneaker, only: :show
  def index
    @brands = Brand.all
    @genders = Gender.all
  end

  def show
  end

  private
  def set_sneaker
    @sneaker = Sneaker.find(params[:id])
  end
end
