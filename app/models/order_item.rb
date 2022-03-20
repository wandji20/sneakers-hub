class OrderItem < ApplicationRecord
  before_save :set_sub_total

  belongs_to :order, optional: true
  belongs_to :sneaker
  belongs_to :shopping_cart, optional: true

  validates :quantity, numericality: { greater_than_or_equal_to: 1 }

  delegate :price, to: :sneaker, prefix: :unit

  def sub_total
    quantity * unit_price
  end

  def set_sub_total
    self[:sub_total] = sub_total
  end
end
