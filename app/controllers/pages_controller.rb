class PagesController < ApplicationController
  def home
    @brands = Brand.all
    @genders = Gender.all
    @sneakers = Sneaker.take(10)
  end

  def about
  end
end
