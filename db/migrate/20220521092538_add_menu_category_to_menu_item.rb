class AddMenuCategoryToMenuItem < ActiveRecord::Migration[7.0]
  def change
    add_column :menu_items, :menu_category, :string, null: false, default: 'food'
  end
end
