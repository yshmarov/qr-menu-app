require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "show" do
    get product_url(products(:monster_classic))
    assert_response :success
  end
end
