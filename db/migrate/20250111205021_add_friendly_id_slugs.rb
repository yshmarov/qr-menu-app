class AddFriendlyIdSlugs < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :slug, :string
    add_index :products, :slug, unique: true

    add_column :orders, :slug, :string
    add_index :orders, :slug, unique: true

    add_column :order_items, :slug, :string
    add_index :order_items, :slug, unique: true
  end
end
