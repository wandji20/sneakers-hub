class AddBrowserStatusToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :browser_status, :boolean, default: true
  end
end
