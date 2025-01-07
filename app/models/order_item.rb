class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :order_id, uniqueness: { scope: :product_id }
  validates :quantity, numericality: { greater_than: 0 }

  def calculate_total_price
    update(total_price: quantity * product.price)
  end
end
