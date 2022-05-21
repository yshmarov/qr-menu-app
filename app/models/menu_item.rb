class MenuItem < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :menu_category, presence: true
  # validates :image_url, presence: true
  has_many :order_items
  has_many :orders, through: :order_items

  enum menu_category: { food: 'food', drinks: 'drinks' }
end
