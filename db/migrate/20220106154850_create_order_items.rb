class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :sneaker, foreign_key: true
      t.float :sub_total
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
