class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  # validates :order_id, scope product_id

  def calculate_total_price
    update(total_price: quantity * product.price)
  end
end
