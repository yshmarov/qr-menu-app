class ShopController < ApplicationController
  # the default url to open from QR
  # /qr?table_delivery=3
  def qr
    session[:table_delivery] = params[:table_delivery]
    redirect_to products_path
  end

  def add_to_cart
    # find or create order
    @order = @current_order.presence || Order.create(
      status: Order.statuses[:draft],
      session_uid: @user_id
    )
    # add to cart
    @product = Product.find(params[:product_id])
    @order_item = @order.order_items.find_or_create_by(product: @product)
    # add +1 item to cart
    @order_item.increment!(:quantity)
    # set delivery delivery
    delivery_method = session[:table_delivery].presence || "To go"
    @order.update(delivery_details: delivery_method)
    # clear table
    session[:table_delivery] = nil
    # balance calculation
    @order_item.calculate_total_price
    @order.calculate_total_price

    @current_order = @order

    notice_text = "#{@product.name} added to cart"

    respond_to do |format|
      format.html do
        redirect_to products_path, notice: notice_text
      end
      format.turbo_stream do
        flash.now[:notice] = notice_text
        render turbo_stream: [
          turbo_stream.replace(@product, partial: "products/product", locals: { product: @product }),
          turbo_stream.replace("nav", partial: "shared/nav"),
          turbo_stream.replace("flash", partial: "shared/flash")
        ]
      end
    end
  end
end
