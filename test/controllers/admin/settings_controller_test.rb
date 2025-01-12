require "test_helper"

module Admin
  class SettingsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @headers = { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(
        SecuredController::USERNAME, SecuredController::PASSWORD
      ) }
    end
    test "should get show" do
      get admin_settings_path, headers: @headers
      assert_response :success
    end

    # Setting.field :app_name, default: 'App'
    test "should update settings" do
      post admin_settings_path, headers: @headers, params: {
        setting: {
          app_name: "New App Name"
        }
      }

      assert_redirected_to admin_settings_path
      assert_equal "Settings updated successfully", flash[:notice]
      assert_equal "New App Name", Setting.app_name
    end

    # Setting.field :user_limit, type: :integer, default: 10, validates: { numericality: true }
    test "should show errors for invalid settings" do
      post admin_settings_path, headers: @headers, params: {
        setting: {
          app_name: "i"
        }
      }

      assert_response :unprocessable_entity
      assert_select "li", /minimum is/
    end
  end
end
