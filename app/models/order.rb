class Order < ApplicationRecord
  enum status: { draft: 'draft',
                 processing: 'processing',
                 delivery: 'delivery',
                 done: 'done' }
  #  cancelled_by_consumer: 'cancelled_by_consumer',
  #  cancelled_by_producer: 'cancelled_by_producer' }
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  validates :status, presence: true

  # validate max 1 draft per user
  scope :queue, -> { where(status: %w[processing delivery]) }

  after_create_commit do
    broadcast_append_to :orders_list, target: 'queue', partial: 'static_pages/queue_item', locals: { order: self }
    broadcast_update_to :orders_list, target: 'queue_count', html: Order.queue.count
  end

  after_update_commit do
    broadcast_append_to :orders_list, target: 'queue', partial: 'static_pages/queue_item', locals: { order: self }
    broadcast_update_to :orders_list, target: 'queue_count', html: Order.queue.count
  end

  # protected
  def calculate_total_price
    update_column :total_price, order_items.map(&:total_price).sum
  end
end
