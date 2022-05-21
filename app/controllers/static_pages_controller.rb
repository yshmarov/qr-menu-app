class StaticPagesController < ApplicationController
  def menu
    @menu_items = MenuItem.order(name: :asc)
  end

  def queue
    @orders = Order.where(status: %w[processing delivery])
  end
end
