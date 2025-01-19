class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :status, default: 'draft', null: false
      t.string :user_id, null: false
      t.integer :rating
      t.text :delivery_details
      t.bigint :total_price, default: 0, null: false
      t.integer :order_items_quantity, default: 0, null: false
      t.string :user_agent
      t.string :ip_address

      t.timestamps
    end
  end
end
