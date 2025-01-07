require "test_helper"

class ShopControllerTest < ActionDispatch::IntegrationTest
  test "add to cart" do
    get products_path
    assert_response :success

    product = products(:monster_classic)
    assert_difference "Order.count", 1 do
      assert_difference "OrderItem.count", 1 do
        post add_to_cart_path(product.id)
      end
    end
    assert_redirected_to products_path
    assert_equal "#{product.name} added to cart", flash[:notice]

    order = Order.last
    assert_equal product, order.products.first
    assert_equal 1, order.order_items.first.quantity
    assert_equal "To go", order.delivery_details

    product2 = products(:rafaello)
    post add_to_cart_path(product2.id)
    assert_redirected_to products_path
    assert_equal "#{product2.name} added to cart", flash[:notice]
    assert_equal 2, order.reload.order_items_quantity
    assert_equal 2, order.order_items.count

    post add_to_cart_path(product2.id)
    order.reload
    assert_equal 3, order.order_items_quantity
    assert_equal 2, order.order_items.count
  end
end
