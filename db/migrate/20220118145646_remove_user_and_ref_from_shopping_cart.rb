class RemoveUserAndRefFromShoppingCart < ActiveRecord::Migration[6.1]
  def change
    remove_column :shopping_carts, :user, :string
    remove_column :shopping_carts, :references, :string
  end
end
