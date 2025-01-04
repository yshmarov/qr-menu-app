require "test_helper"

class MenuControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get menu_url
    assert_response :success

    menu_item_drink = menu_items(:monster_classic)
    menu_item_food = menu_items(:rafaello)

    assert_match menu_item_drink.name, response.body
    assert_match menu_item_food.name, response.body

    # filter by category
    get menu_url(menu_category: "food")
    assert_response :success
    assert_match menu_item_food.name, response.body
    assert_no_match menu_item_drink.name, response.body
  end
end
