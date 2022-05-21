class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :menu_item
  # validates :order_id, scope menu_item_id
end
