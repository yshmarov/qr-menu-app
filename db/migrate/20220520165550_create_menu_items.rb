class CreateMenuItems < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.integer :price
      t.string :image_url

      t.timestamps
    end
  end
end
