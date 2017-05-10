require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  describe 'GET index' do
    context 'if more products than number of products on one page' do
      before do
        (1..13).each { create(:product) }
      end

      # TASK­-3 test
      it 'get first page' do
        get :index

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).count).to eq 10
      end

      # TASK­-3 test
      it 'get second page' do
        get :index, params: { page: 2 }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).count).to eq 3
      end
    end

    context 'if diferent names and prices' do
      before do
        create(:product, name: 'White Cheese', price: 22.5)
        create(:product, name: 'Olive oil', price: 28.7)
        create(:product, name: 'Chocolate', price: 10.8)
        create(:product, name: 'Pen', price: 2.1)
        create(:product, name: 'Bread', price: 3.8)
        create(:product, name: 'Apple', price: 6.0)
        create(:product, name: 'Chocolate pie', price: 7.1)
      end

      # TASK­-3 test
      it 'sort by name' do
        get :index, params: { sort: 'name' }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).first['name']).to eq 'Apple'
      end

      # TASK­-3 test
      it 'sort by price' do
        get :index, params: { sort: 'price' }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).first['price'].to_f).to eq 2.1
      end

      # TASK-4 - test
      it 'cheaper than 5€' do
        get :index, params: { max: 5 }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).count).to eq 2
      end

      # TASK-4 - test
      it '5­€ - 10€' do
        get :index, params: { min: 5, max: 10 }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).count).to eq 2
      end

      # TASK-4 - test
      it 'more expensive than 10€' do
        get :index, params: { min: 10 }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).count).to eq 3
      end

      # TASK-5 - test
      it "search query 'oi'" do
        get :index, params: { q: 'oi' }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).count).to eq 1
        expect(JSON.parse(response.body).first['name']).to eq 'Olive oil'
      end

      # TASK-5 - test
      it "search query 'heese'" do
        get :index, params: { q: 'heese' }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).count).to eq 0
      end

      # TASK-5 - test
      it "search query 'choco', more expensive than 5€ and sort by price" do
        get :index, params: { q: 'choco', min: 5, sort: 'price' }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body).count).to eq 2
        expect(JSON.parse(response.body).first['price'].to_f).to eq 7.1

      end
    end
  end

  # TASK-1 - test
  describe 'POST create' do
    before { @params = { product: { name: 'Product name', price: 100, quantity: 10 } } }

    context 'if set valid params' do
      it 'create product' do
        post :create, params: @params

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq Product.last.id
      end
    end

    context 'if set not valid params' do
      before { @params[:product][:quantity] = -1}
      it 'not create product' do
         post :create, params: @params

        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end


  describe 'GET show' do
    let!(:product) { create(:product) }

    context 'if product exist in db' do
      it 'get product' do
        get :show, params: { id: product.id }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq product.id
      end
    end

    context 'if product not exist in db' do
      it 'get 404 error' do
        get :show, params: { id: product.id + 1 }

        expect(response).to have_http_status(404)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['error']).to eq('Not found')
      end
    end
  end

  # TASK-1 - test
  describe 'PATCH update' do
    let!(:product) { create(:product) }
    before { @params = { product: { name: 'Updated name', price: 100, quantity: 10 } } }

    context 'if set valid params' do
      it 'update product' do
        patch :update, params: @params.merge({ id: product.id })

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq('application/json')
        expect(JSON.parse(response.body)['id']).to eq Product.last.id
        expect(JSON.parse(response.body)['name']).to eq Product.last.name
      end
    end

    context 'if set not valid params' do
      before { @params[:product][:quantity] = -1}
      it 'not update product' do
         patch :update, params: @params.merge({ id: product.id })

        expect(response).to have_http_status(422)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  # TASK-1 - test
  describe 'DELETE destroy' do
    context 'if set valid params' do
      let!(:product) { create(:product) }

      it 'set product unavailable' do
        delete :destroy, params: { id: product.id }

        expect(response).to have_http_status(:success)
        expect(response.content_type).to eq(nil)
        expect(Product.find(product.id).available).to eq false
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
