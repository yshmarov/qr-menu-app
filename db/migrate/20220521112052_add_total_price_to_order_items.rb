class AddTotalPriceToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :total_price, :integer, default: 0, null: false
    add_column :orders, :total_price, :integer, default: 0, null: false
  end
end
