class OrderItemsController < ApplicationController
  def destroy
    @order_item = OrderItem.find(params[:id])
    if @order_item.order.draft?
      @order_item.destroy
      @order_item.order.calculate_total_price
      redirect_to @order_item.order, notice: 'Item was removed from the order.'
    else
      redirect_to @order_item.order, notice: 'Items can be removed only from draft orders.'
    end
  end
end
