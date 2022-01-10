class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :sneaker

  def sub_total
    quantity * sneaker.price
  end

end
