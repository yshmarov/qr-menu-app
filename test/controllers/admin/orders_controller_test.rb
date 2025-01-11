require "test_helper"

class Admin::OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(
      SecuredController::USERNAME, SecuredController::PASSWORD
    ) }
  end

  test "index" do
    get admin_orders_url
    assert_response :unauthorized

    get admin_orders_url, headers: @headers
    assert_response :success
  end

  test "show" do
    order = Order.create!(status: Order.statuses[:submitted], user_id: 1)
    get admin_order_url(order), headers: @headers
    assert_response :success
  end

  test "update" do
    order = Order.create!(status: Order.statuses[:submitted], user_id: 1)
    patch admin_order_url(order), headers: @headers, params: {
      order: { status: Order.statuses[:processing] }
    }

    assert_redirected_to admin_order_url(order)
  end
end
