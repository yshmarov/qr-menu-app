require "test_helper"

class StatsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get admin_stats_url
    assert_response :unauthorized

    get admin_stats_url,
        headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(
          SecuredController::USERNAME, SecuredController::PASSWORD
        ) }
    assert_response :success
  end
end
