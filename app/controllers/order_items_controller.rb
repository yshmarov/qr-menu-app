class OrderItemsController < ApplicationController
  def destroy
    @order_item = OrderItem.find(params[:id])
    return unless @order_item.order.draft?

    @order_item.destroy
    @order_item.order.calculate_total_price
    redirect_to @order_item.order, notice: t(".destroy.notice")
  end
end
