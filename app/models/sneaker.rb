class Sneaker < ApplicationRecord
  belongs_to :brand
  belongs_to :gender

  scope :filter_by_brand, -> (brand_id) {where('brand_id = ?', brand_id)}
  scope :filter_by_gender, -> (gender_id) {where('gender_id = ?', gender_id)}
  scope :increasing_price, -> {order(price: :asc)}
  scope :decreasing_price, -> {order(price: :desc)}
  scope :release_date, -> {order(release_date: :desc)}
end
