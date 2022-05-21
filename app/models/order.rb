class Order < ApplicationRecord
  enum status: { draft: 'draft',
                 processing: 'processing',
                 delivery: 'delivery',
                 done: 'done' }
  #  cancelled_by_consumer: 'cancelled_by_consumer',
  #  cancelled_by_producer: 'cancelled_by_producer' }
  has_many :order_items
  has_many :menu_items, through: :order_items
  validates :status, presence: true

  # validate max 1 draft per user

  def calculate_total_price
    update_column :total_price, order_items.map(&:total_price).sum
  end
end
