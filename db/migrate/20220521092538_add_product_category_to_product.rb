class AddProductCategoryToProduct < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :category, :string, null: false, default: 'food'
  end
end
