require 'spec_helper'

describe BidsController do
  before(:each) do
    @item = Item.create(name: 'foo', description: 'bar')
    @user = User.create(password: 'password', email: 'foo@example.com')
    @bid = Bid.create(price: '10.00', user: @user, item: @item)
  end

  describe 'GET #index' do
    it 'responds successfully with HTTP 200 status' do
      get :index, item_id: @item
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with HTTP 200 status' do
      get :show, id: @bid, item_id: @item
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #edit' do
    it 'responds successfully with HTTP 200 status' do
      get :edit, id: @bid, item_id: @item 
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'POST #create' do
    it 'responds successfull 302 redirect' do
      post :create, item_id: @item.id, bid: {price: 1000}
      expect(response).to redirect_to(item_bids_url(assigns(:bid)))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Bid was successfully created.') 
    end
  end

  describe 'PATCH/PUT #update' do
    it 'should update the record and redirect successfully for PATCH' do
      patch :update, id: @bid, item_id: @item.id, bid: { price: 5000 }
      expect(response).to redirect_to(item_bids_url(assigns(:bid)))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Bid was successfully updated.') 
    end

    it 'should update the record and redirect successfully for POST' do
      put :update, id: @bid, item_id: @item.id, bid: { price: 5000 }
      expect(response).to redirect_to(item_bids_url(assigns(:bid)))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Bid was successfully updated.') 
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the record and redirect successfully' do
      delete :destroy, item_id: @item, id: @bid 
      expect(response).to redirect_to(item_bids_path)
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Bid was successfully destroyed.') 
    end
  end
end
