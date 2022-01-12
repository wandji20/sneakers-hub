class PagesController < ApplicationController
  before_action :save_url, only: :home
  def home
    @sneakers = Sneaker.release_date.take(10)
  end

  def checkout; end

  def about; end
end
