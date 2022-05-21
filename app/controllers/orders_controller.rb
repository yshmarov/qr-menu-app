class OrdersController < ApplicationController
  # current_user orders
  before_action :set_order, only: %i[show update]

  def index
    @orders = @my_orders.order(created_at: :desc)
  end

  def show; end

  def update
    # change status (pay)
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: 'Ordered!.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_order
    @order = @my_orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status)
  end
end
