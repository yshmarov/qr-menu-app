class MenuController < ApplicationController
  def index
    @menu_items = if params[:menu_category].present?
                    MenuItem.where(menu_category: params[:menu_category]).order(name: :asc)
                  else
                    MenuItem.order(menu_category: :desc, name: :asc)
                  end
  end

  # the default url to open from QR
  def qr
    session[:table_delivery] = params[:table_delivery]
    redirect_to menu_path
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
    # set delivery delivery
    delivery_method = session[:table_delivery].presence || 'To go'
    @order.update(delivery_details: delivery_method)
    # clear table
    session[:table_delivery] = nil
    # balance calculation
    @order_item.calculate_total_price
    @order.calculate_total_price

    @current_order = @order

    notice_text = "#{@menu_item.name} added to cart"

    respond_to do |format|
      format.html do
        redirect_to menu_url, notice: notice_text
      end
      format.turbo_stream do
        flash.now[:notice] = notice_text
        render turbo_stream: [
          turbo_stream.replace(@menu_item, partial: 'menu/menu_item', locals: { menu_item: @menu_item }),
          turbo_stream.replace('header_navigation', partial: 'shared/header'),
          turbo_stream.replace('flash', partial: 'shared/flash')
        ]
      end
    end
  end
end
