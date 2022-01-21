class AddUserRefToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :user_id, :integer
    add_index :orders, :user_id
  end
end
