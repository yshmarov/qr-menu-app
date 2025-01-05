require "test_helper"

class OrderItemsControllerTest < ActionDispatch::IntegrationTest
  test "destroy" do
    order = Order.create(user_id: "123")
    order.order_items.create(product: products(:monster_classic), quantity: 2)
    assert_equal 1, order.order_items.count

    delete order_order_item_url(order, order.order_items.first)
    assert_redirected_to order_path(order)
    assert_equal 0, order.order_items.count
  end
end
