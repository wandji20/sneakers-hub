class SneakersController < ApplicationController
  def index
    @brands = Brand.all
    @genders = Gender.all
  end

  def show
  end
end
