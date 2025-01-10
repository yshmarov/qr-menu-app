class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.bigint :price
      t.string :image_url
      t.string :category, null: false, default: 'food'
      t.text :description

      t.timestamps
    end
  end
end
