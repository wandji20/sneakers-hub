class PagesController < ApplicationController
  def home
    @brands = Brand.all
    @genders = Gender.all
  end

  def about
  end
end
