module Admin
  class OrdersController < SecuredController
    before_action :set_order, only: %i[show update]

    # orders being worked on
    def index
      @orders = Order.queued.order(created_at: :desc)
    end

    def show; end

    def update
      # @order.update(order_params)
      # redirect_to root_url
      if @order.update(order_params)
        redirect_to [ :admin, @order ],
                    notice: "Status updated: #{@order.status_previous_change}."
      else
        render :edit, status: :unprocessable_entity
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
