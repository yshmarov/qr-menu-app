module Admin
  class StatsController < SecuredController
    def index
      @most_popular_menu_items = OrderItem.joins(:menu_item).group("menu_items.name").count
      @satisfaction = Order.group(:rating).count
      @income_per_day = Order.all.group_by_day(:created_at).sum(:total_price)
    end
  end
end
