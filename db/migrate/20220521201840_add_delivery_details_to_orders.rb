class AddDeliveryDetailsToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :delivery_details, :text
  end
end
