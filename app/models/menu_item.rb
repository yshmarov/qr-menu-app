class MenuItem < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :menu_category, presence: true
  validates :image_url, presence: true

  has_many :order_items, dependent: :restrict_with_error
  has_many :orders, through: :order_items

  def self.menu_categories
    I18n.t('activerecord.attributes.menu_item.menu_categories')
  end

  validates :menu_category, inclusion: { in: menu_categories.stringify_keys.keys }

  def items_in_cart(current_order)
    order_items.find_by(order: current_order)&.quantity
  end
end
