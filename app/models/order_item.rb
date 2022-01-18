class OrderItem < ApplicationRecord
  before_save :set_sub_total
  belongs_to :order
  belongs_to :sneaker
  belongs_to :shopping_cart

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  def sub_total
    quantity * sneaker.price
  end

  def set_sub_total
    self[:sub_total] = sub_total
  end
end
