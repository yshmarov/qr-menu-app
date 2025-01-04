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
end
