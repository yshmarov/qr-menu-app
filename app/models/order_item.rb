class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  # validates :order_id, scope menu_item_id

  def calculate_total_price
    update_column :total_price, (quantity * menu_item.price)
  end
end
