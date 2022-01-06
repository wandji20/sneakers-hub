class PagesController < ApplicationController
  def home
    @brands = Brand.all
    @genders = Gender.all
    @sneakers = Sneaker.release_date.take(10)
  end

  def about; end
end
