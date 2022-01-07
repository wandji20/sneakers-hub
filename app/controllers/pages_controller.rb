class PagesController < ApplicationController
  before_action :save_url, only: :home
  def home
    @brands = Brand.all
    @genders = Gender.all
    @sneakers = Sneaker.release_date.take(10)
  end

  def about; end
end
