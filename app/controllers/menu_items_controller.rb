class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: %i[edit update destroy]

  def index
    @menu_items = MenuItem.order(name: :asc)
  end

  def new
    @menu_item = MenuItem.new
  end

  def edit; end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    respond_to do |format|
      if @menu_item.save
        format.html { redirect_to menu_items_url, notice: 'Menu item was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @menu_item.update(menu_item_params)
        format.html { redirect_to menu_items_url, notice: 'Menu item was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu_item.destroy
    respond_to do |format|
      format.html { redirect_to menu_items_url, notice: 'Menu item was successfully destroyed.' }
    end
  end

  private

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :price, :image_url, :menu_category)
  end
end
