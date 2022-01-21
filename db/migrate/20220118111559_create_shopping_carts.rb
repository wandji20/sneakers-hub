class CreateShoppingCarts < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_carts do |t|
      t.string :references
      t.string :user

      t.timestamps
    end
  end
end
