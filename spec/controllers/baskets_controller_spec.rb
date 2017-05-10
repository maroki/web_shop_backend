require 'rails_helper'

RSpec.describe BasketsController, type: :controller do

  # TASK-2 - test
  describe "POST create" do
    let!(:product_01) { create(:product, quantity: 10) }
    let!(:product_02) { create(:product, quantity: 5) }


    context 'if set valid params' do

      before {
        @params = { basket: {
          basket_products_attributes: [
            { product_id: product_01.id, quantity: 3 },
            { product_id: product_02.id, quantity: 3 }
          ]
        } }
      }

      it 'create basket' do
        post :create, params: @params

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq Basket.last.id
      end
    end

    context 'if set not valid params' do
      before {
        @params = { basket: {
          basket_products_attributes: [{ product_id: product_01.id, quantity: -3 }]
          }
        }
      }
      it 'not create product' do
         post :create, params: @params

        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'if set more product quantity in basket than catalog' do
      before {
        @params = { basket: {
          basket_products_attributes: [{ product_id: product_01.id, quantity: 30}]
          }
        }
      }
      it 'not create product' do
         post :create, params: @params

        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end


  describe "GET show" do
    let!(:basket) { create(:basket) }

    context 'if basket exist in db' do
      it 'get basket' do
        get :show, params: { id: basket.id }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq basket.id
      end
    end

    context 'if basket not exist in db' do
      it 'get 404 error' do
        get :show, params: { id: basket.id + 1 }

        expect(response).to have_http_status(404)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['error']).to eq('Not found')
      end
    end
  end

  # TASK-2 - test
  describe "PATCH update" do
    let!(:product) { create(:product, quantity: 10) }
    let!(:basket) do
      basket = create(:basket)
      basket.basket_products.create(product_id: product.id, quantity: 5)
      basket
    end

    context 'if set correct quantity' do
      before do
        @params = {
          basket: {
            basket_products_attributes: [{
              id: basket.basket_products.first.id,
              product_id: product.id,
              quantity: 10
            }]
          }
        }
      end

      it 'update basket' do
        patch :update, params: @params.merge({ id: basket.id })

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq Basket.last.id
        expect(Product.last.quantity).to eq 0
      end
    end

    context 'if set basket_product quantity incorrect' do
      before do
        @params = {
          basket: {
            basket_products_attributes: [{
              id: basket.basket_products.first.id,
              product_id: product.id,
              quantity: 100
            }]
          }
        }
      end

      it 'not update basket' do
        patch :update, params: @params.merge({ id: basket.id })

        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
        expect(Product.last.quantity).to eq 5
      end
    end
  end

  # TASK-2 - test
  describe "DELETE destroy" do
    context 'if set valid params' do
      let!(:basket) { create(:basket) }

      it 'basket wil be deleted' do
        delete :destroy, params: { id: basket.id }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq(nil)
        expect(Basket.count).to eq 0
      end
    end

    context 'if try to delete non existent record' do
      it 'get 404 error' do
        delete :destroy, params: { id: 100 }

        expect(response).to have_http_status(404)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['error']).to eq('Not found')
      end
    end
  end

end
