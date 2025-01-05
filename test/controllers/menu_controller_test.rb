require "test_helper"

class MenuControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get menu_url
    assert_response :success

    product_drink = products(:monster_classic)
    product_food = products(:rafaello)

    assert_match product_drink.name, response.body
    assert_match product_food.name, response.body

    # filter by category
    get menu_url(category: "food")
    assert_response :success
    assert_match product_food.name, response.body
    assert_no_match product_drink.name, response.body
  end
end
