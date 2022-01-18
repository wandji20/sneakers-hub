class ShoppingCart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items
end
