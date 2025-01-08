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
    assert_equal "Ordered!", flash[:notice]
  end
end
