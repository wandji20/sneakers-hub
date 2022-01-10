class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :sneaker, null: false, foreign_key: true
      t.float :sub_total
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end
