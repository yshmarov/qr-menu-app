class Admin::MenuItemsController < SecuredController
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
    if @menu_item.save
      redirect_to %i[admin menu_items], notice: 'Menu item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @menu_item.update(menu_item_params)
      redirect_to %i[admin menu_items], notice: 'Menu item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @menu_item.destroy
    redirect_to %i[admin menu_items], notice: 'Menu item was successfully destroyed.'
  end

  private

  def set_menu_item
    @menu_item = MenuItem.find(params[:id])
  end

  def menu_item_params
    params.require(:menu_item).permit(:name, :price, :image_url, :menu_category)
  end
end
