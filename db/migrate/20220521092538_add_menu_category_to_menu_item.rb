class AddMenuCategoryToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :menu_category, :string, null: false, default: 'food'
  end
end
