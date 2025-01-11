class Admin::ProductsController < SecuredController
  before_action :set_product, only: %i[edit update destroy]

  def index
    @categories = Product.distinct.pluck(:category).sort
    products = if params[:category].present?
                    Product.where(category: params[:category]).order(name: :asc)
    else
                    Product.order(category: :asc, name: :asc)
    end
    products = products.search(params[:query]) if params[:query].present?
    @grouped_products = products.group_by(&:category)

    # render "products/index"
  end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to %i[admin products], notice: "Product created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to %i[admin products], notice: "Product updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    redirect_to %i[admin products], notice: "Product destroyed."
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :image_url, :category, :description)
  end
end
