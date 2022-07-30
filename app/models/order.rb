class Order < ApplicationRecord
  belongs_to :user, optional: true
  has_many :order_items, dependent: :destroy
  enum status: { incomplete: 0, complete: 1, failed: 2 }

  accepts_nested_attributes_for :order_items

  def total
    order_items.sum(:sub_total)
  end

  def payment_attributes
    amount = (total * 100).to_i
    {
      amount: amount,
      currency: 'eur',
      payment_method_types: ['card'],
      metadata: {
        order_id: id
      }
    }
  end
end
