class Order < ApplicationRecord
  enum :status, { draft: "draft",
                  submitted: "submitted",
                  processing: "processing",
                  delivery: "delivery",
                  done: "done" }

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :status, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }, allow_blank: true

  # TODO: validate max 1 draft per user
  scope :queued, -> { where(status: %w[submitted processing delivery]) }

  def next_status
    Order.statuses.keys.split(status).last.first
  end

  def statuses_for_display
    if status == "draft"
      [status]
    elsif status == "done"
      [status]
    else
      Order.statuses.reject { |k, _v| %w[draft done].include?(k) }.keys
    end
  end

  after_update_commit do
    broadcast_refresh_to :orders
    broadcast_refresh
  end

  def calculate_total_price
    update(total_price: order_items.map(&:total_price).sum)
    update(order_items_quantity: order_items.map(&:quantity).sum)
  end
end
