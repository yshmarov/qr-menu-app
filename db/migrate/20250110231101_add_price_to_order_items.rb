class AddPriceToOrderItems < ActiveRecord::Migration[8.0]
  def change
    add_column :order_items, :price, :bigint, null: false, default: 0
  end
end
