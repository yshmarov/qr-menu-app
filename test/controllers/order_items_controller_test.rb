require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "destroy" do
    product = products(:monster_classic)
    post add_to_cart_path(product.id)
    post add_to_cart_path(product.id)

    order = Order.last
    assert_equal 1, order.order_items.count
    assert_equal 2, order.order_items_quantity

    delete order_order_item_url(order, order.order_items.first)
    assert_redirected_to order_path(order)
    assert_equal 0, order.order_items.count
    assert_equal 0, order.reload.order_items_quantity
  end
end
