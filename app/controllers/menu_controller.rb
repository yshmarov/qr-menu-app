class MenuController < ApplicationController
  def index
    @menu_items = if params[:menu_category].present?
                    MenuItem.where(menu_category: params[:menu_category]).order(name: :asc)
                  else
                    MenuItem.order(menu_category: :desc, name: :asc)
                  end
  end

  def add_to_cart
    # find or create order
    @order = if @current_order.present?
               @current_order
             else
               Order.create(
                 status: Order.statuses[:draft],
                 session_uid: @user_id
               )
             end
    # add to cart
    @menu_item = MenuItem.find(params[:menu_item_id])
    @order_item = @order.order_items.find_or_create_by(menu_item: @menu_item)
    # add +1 item to cart
    @order_item.increment!(:quantity)
    # balance calculation
    @order_item.calculate_total_price
    @order.calculate_total_price

    respond_to do |format|
      format.html do
        redirect_to menu_url, notice: "#{@menu_item.name} added to cart"
      end
    end
  end
end
