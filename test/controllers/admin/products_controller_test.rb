require "test_helper"

class Admin::ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @headers = { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials(
      SecuredController::USERNAME, SecuredController::PASSWORD
    ) }
  end

  test "index" do
    get admin_products_url
    assert_response :unauthorized

    get admin_products_url, headers: @headers
    assert_response :success
  end

  test "new" do
    get new_admin_product_url, headers: @headers
    assert_response :success
  end

  test "create" do
    assert_difference("Product.count") do
      post admin_products_url, headers: @headers, params: {
        product: { name: "Product", price: 1, category: "food", image_url: "image_url" }
      }
    end

    assert_redirected_to admin_products_url
  end

  test "update" do
    product = products(:monster_classic)
    patch admin_product_url(product), headers: @headers, params: {
      product: { name: "Product" }
    }

    assert_redirected_to admin_products_url
  end

  test "destroy" do
    product = products(:monster_classic)
    assert_difference("Product.count", -1) do
      delete admin_product_url(product), headers: @headers
    end

    assert_redirected_to admin_products_url
  end
end
