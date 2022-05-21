class StaticPagesController < ApplicationController
  def menu
    @menu_items = if params[:menu_category].present?
                    MenuItem.where(menu_category: params[:menu_category]).order(name: :asc)
                  else
                    MenuItem.order(menu_category: :desc, name: :asc)
                  end
  end

  def queue
    @orders = Order.queue
  end
end
