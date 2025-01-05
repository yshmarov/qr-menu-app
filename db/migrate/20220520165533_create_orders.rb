class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :status, default: 'draft', null: false
      t.string :user_id, null: false
      t.integer :rating
      t.text :delivery_details
      t.integer :total_price, default: 0, null: false

      t.timestamps
    end
  end
end
