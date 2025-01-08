require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get orders_url
    assert_response :success
  end

  test "update" do
    product = products(:monster_classic)
    post add_to_cart_url(product.id)
    order = Order.last

    patch order_url(order), params: { order: { status: "submitted" } }
    assert_response :redirect
    assert_redirected_to order_url(order)
    assert_equal "Order submitted! We are preparing it for you.", flash[:notice]

    patch order_url(order), params: { order: { status: "delivery", rating: 5 } }
    assert_equal "submitted", order.reload.status
    assert_nil order.reload.rating

    order.done!
    assert_equal "done", order.reload.status
    patch order_url(order), params: { order: { status: "delivery", rating: 4 } }
    assert_equal "done", order.reload.status
    assert_not_nil order.reload.rating

    # rating
    patch order_url(order), params: { order: { rating: 5 } }
    assert_equal 5, order.reload.rating
  end
end
