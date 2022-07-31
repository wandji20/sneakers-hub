class AddStripeDetailsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :payment_intent_id, :string
    add_column :orders, :payment_intent_client_id, :string
    add_column :orders, :status, :integer, default: 0
    remove_column :orders, :browser_status
  end
end
