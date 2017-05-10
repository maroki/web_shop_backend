class ProductsController < ApplicationController
  before_action :fetch_product, only: [:show, :update, :destroy]

  def index
    products = QueryProducts.new(search_scope, search_params).search

    render json: products, status: :ok
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: product, status: :ok
    else
      render json: product.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @product
  end

  def update
    if @product.update(product_params)
      render json: @product, status: :ok
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @product.unavailable!
    head :no_content
  end

  private

  def product_params
    params.require(:product).permit(:name, :quantity, :price, :available)
  end

  def search_params
    params.permit(:q, :min, :max, :sort, :page)
  end

  def search_scope
    Product.available
  end

  def fetch_product
    @product = Product.find(params[:id])
  rescue
    render json: { error: 'Not found' }, status: 404
  end
end
