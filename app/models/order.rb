class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  scope :opened, -> { where(browser_status: true) }

  accepts_nested_attributes_for :order_items

  def total
    order_items.sum(:sub_total)
  end
end
