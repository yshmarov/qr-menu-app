module ApplicationHelper
  def active_link_to(path, &block)
    link_to path, class: ('active' if current_page?(path)), &block
  end

  def order_pay_label(order)
    'Complete order' if order.draft?
  end
end
