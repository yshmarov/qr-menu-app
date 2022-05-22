class AddRatingToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :rating, :integer
  end
end
