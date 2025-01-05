class Admin::ProductsController < SecuredController
  before_action :set_product, only: %i[edit update destroy]

  def index
    @products = Product.order(name: :asc)
  end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to %i[admin products], notice: "Menu item created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to %i[admin products], notice: "Menu item updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to %i[admin products], notice: "Menu item destroyed."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :image_url, :menu_category)
  end
end
