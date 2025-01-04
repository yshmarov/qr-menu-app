module Admin
  class StatsController < SecuredController
    def index
      @most_popular_menu_items = OrderItem.joins(:menu_item).group("menu_items.name").count
      @satisfaction = Order.group(:rating).count
    end
  end
end
