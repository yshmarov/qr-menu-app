class ProductsController < ApplicationController
  before_action :set_product, only: %i[show]

  def index
    @categories = Product.distinct.pluck(:category).sort
    products = if params[:category].present?
                    Product.where(category: params[:category]).order(name: :asc)
    else
                    Product.order(category: :asc, name: :asc)
    end
    products = products.search(params[:query]) if params[:query].present?
    @grouped_products = products.group_by(&:category)
  end

  def show; end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
