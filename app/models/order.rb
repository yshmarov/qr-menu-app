class Order < ApplicationRecord
  enum status: { draft: 'draft',
                 submitted: 'submitted',
                 processing: 'processing',
                 delivery: 'delivery',
                 done: 'done' }
  has_many :order_items, dependent: :destroy
  has_many :menu_items, through: :order_items
  validates :status, presence: true

  # validate max 1 draft per user
  scope :queued, -> { where(status: %w[submitted processing delivery]) }

  # protected
  after_create_commit do
    broadcast_queue
  end

  after_update_commit do
    broadcast_queue
  end

  def broadcast_queue
    broadcast_append_to :orders_list, target: 'queue', partial: 'queue/queue_item', locals: { order: self }
    broadcast_update_to :orders_list, target: 'queue_count', html: Order.queued.count
  end

  def calculate_total_price
    update_column :total_price, order_items.map(&:total_price).sum
  end
end
