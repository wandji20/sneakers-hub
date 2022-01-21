class ShoppingCart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items
  accepts_nested_attributes_for :order_items
end
