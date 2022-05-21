class StaticPagesController < ApplicationController
  def menu
    @menu_items = MenuItem.order(menu_category: :desc, name: :asc)
  end

  def queue
    @orders = Order.queue
  end
end
