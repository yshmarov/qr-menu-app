class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :category, presence: true
  validates :image_url, presence: true

  has_many :order_items, dependent: :restrict_with_error
  has_many :orders, through: :order_items

  scope :search, ->(query) { where("name ILIKE ?", "%#{query}%") }

  extend FriendlyId
  friendly_id :name, use: [:finders, :slugged]

  def self.categories
    I18n.t("config.categories")
  end

  validates :category, inclusion: { in: categories.stringify_keys.keys }

  def items_in_cart(current_order)
    order_items.find_by(order: current_order)&.quantity
  end
end
