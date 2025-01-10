class ChangePriceIntegersToBigint < ActiveRecord::Migration[8.0]
  def change
    change_column :products, :price, :bigint
    change_column :orders, :total_price, :bigint
    change_column :order_items, :total_price, :bigint
  end
end
