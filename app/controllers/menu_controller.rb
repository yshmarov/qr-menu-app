class MenuController < ApplicationController
  def index
    @menu_items = if params[:menu_category].present?
                    MenuItem.where(menu_category: params[:menu_category]).order(name: :asc)
                  else
                    MenuItem.order(menu_category: :desc, name: :asc)
                  end
  end
end
