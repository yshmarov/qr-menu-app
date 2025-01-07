class Order < ApplicationRecord
  enum :status, { draft: "draft",
                  submitted: "submitted",
                  processing: "processing",
                  delivery: "delivery",
                  done: "done" }

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true

  # TODO: validate max 1 draft per user
  scope :queued, -> { where(status: %w[submitted processing delivery]) }

  def next_status
    Order.statuses.keys.split(status).last.first
  end

  COLOR_STATUSES = { submitted: "red",
                     processing: "yellow",
                     delivery: "green" }.freeze

  # protected
  after_update_commit do
    broadcast_queue
    broadcast_order_status
  end

  def broadcast_queue
    # TODO: update order.done -> broadcast remove from queue
    unless draft?
      broadcast_append_to :orders_list, target: "queue", partial: "queue/queue_item", locals: { order: self }
    end
    broadcast_update_to :orders_list, target: "queue_count", html: Order.queued.count
  end

  def broadcast_order_status
    # so that the customer does not need to open queue. He can see it on the order page
    broadcast_update_to [ self, :status ], target: "order_status", partial: "orders/status", locals: { order: self }
  end

  def calculate_total_price
    update(total_price: order_items.map(&:total_price).sum)
    update(order_items_quantity: order_items.map(&:quantity).sum)
  end
end
