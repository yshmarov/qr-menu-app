require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get orders_url
    assert_response :success
  end
end
