class BasketsController < ApplicationController
  before_action :fetch_basket, except: [:create]

  def create
    basket = Basket.new(basket_params)
    if basket.save
      render json: basket, status: :ok
    else
      render json: basket.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @basket
  end

  def update
    if @basket.update(basket_params)
      render json: @basket, status: :ok
    else
      render json: @basket.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @basket.destroy
    head :no_content
  end

  private

  def basket_params
    params.require(:basket).permit(basket_products_attributes: [:id, :product_id, :quantity, :_destroy])
  end

  def fetch_basket
    @basket = Basket.find(params[:id])
  rescue
    render json: { error: 'Not found' }, status: 404
  end
end
