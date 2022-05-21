class OrderItemsController < ApplicationController
  def destroy
    @order_item = OrderItem.find(params[:id])
    @order_item.destroy
    respond_to do |format|
      format.html { redirect_to @order_item.order, notice: 'Item was removed from the order.' }
    end
  end
end
