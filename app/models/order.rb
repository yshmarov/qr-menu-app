class Order < ApplicationRecord
  enum :status, { draft: "draft",
                  submitted: "submitted",
                  processing: "processing",
                  delivery: "delivery",
                  done: "done" }

  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  validates :user_id, presence: true
  validates :status, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }, allow_blank: true

  scope :queued, -> { where(status: %w[submitted processing delivery]) }

  extend FriendlyId
  friendly_id :generate_random_slug, use: [ :finders, :slugged ]

  def next_status
    Order.statuses.keys.split(status).last.first
  end

  def statuses_for_display
    return [ status ] if %w[draft done].include?(status)

    self.class.statuses.reject { |k, _v| %w[draft done].include?(k) }.keys
  end

  after_update_commit do
    broadcast_refresh_to :orders
    broadcast_refresh
  end

  def calculate_total_price
    update(
      total_price: order_items.sum(&:total_price),
      order_items_quantity: order_items.sum(&:quantity)
    )
  end
end
