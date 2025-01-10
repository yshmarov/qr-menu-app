class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 0, null: false
      t.bigint :total_price, default: 0, null: false
      t.bigint :price, default: 0, null: false

      t.timestamps
    end
  end
end
