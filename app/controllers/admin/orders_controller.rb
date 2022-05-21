module Admin
  class OrdersController < SecuredController
    before_action :set_order, only: %i[show edit update]

    # orders being worked on
    def index
      @orders = Order.queued.order(created_at: :desc)
    end

    def show; end

    def update
      # @order.update(order_params)
      # redirect_to root_url
      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to [:admin, @order], notice: 'Order was successfully updated.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:status)
    end
  end
end
