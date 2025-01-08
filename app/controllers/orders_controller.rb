class OrdersController < ApplicationController
  # current_user orders
  before_action :set_order, only: %i[show update]

  def index
    @orders = @my_orders.order(created_at: :desc)
  end

  def show
    @order_items = @order.order_items.order(created_at: :desc)
  end

  def update
    return redirect_to @order, notice: "Order must have at least one item" if @order.order_items.empty?

    case @order.status
    when "draft"
      notice = handle_payment
    when "done"
      notice = handle_rating
    end

    redirect_to order_url(@order), notice:
  end

  private

  def handle_payment
    # TODO: implement payment
    @order.submitted!
    t(".submitted")
  end

  def handle_rating
    @order.update(order_params)
    t(".rating")
  end

  def set_order
    @order = @my_orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:rating)
  end
end
