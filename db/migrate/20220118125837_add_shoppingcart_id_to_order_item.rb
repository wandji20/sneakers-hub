class AddShoppingcartIdToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :shopping_cart_id, :integer
    add_index :order_items, :shopping_cart_id
  end
end
