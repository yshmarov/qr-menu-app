class Order < ApplicationRecord
  has_many :order_items
  has_many :menu_items, through: :order_items
end
