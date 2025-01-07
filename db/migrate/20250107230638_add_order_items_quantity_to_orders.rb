class AddOrderItemsQuantityToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :order_items_quantity, :integer, default: 0, null: false
  end
end
