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
    # TODO: the status should not be editable from here. it can only be moved from Draft to Submitted when payment is successful
    # TODO: implement payment
    # change status (pay)
    return unless @order.update(order_params)

    notice_text = if order_params[:status].present?
                    "Ordered!"
    else
                    "Your rating: #{order_params[:rating]}"
    end
    redirect_to order_url(@order), notice: notice_text
  end

  private

  def set_order
    @order = @my_orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :rating)
  end
end
