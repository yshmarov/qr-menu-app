module OrderHelper
  def order_pay_label(order)
    "Complete order" if order.draft?
  end
end
