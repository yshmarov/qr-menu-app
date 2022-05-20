class MenuItem < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  # validates :image_url, presence: true
  has_many :order_items
  has_many :orders, through: :order_items
end
