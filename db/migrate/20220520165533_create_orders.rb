class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      # t.string :status
      t.string :status, default: 'draft', null: false
      t.string :session_uid, null: false

      t.timestamps
    end
  end
end
