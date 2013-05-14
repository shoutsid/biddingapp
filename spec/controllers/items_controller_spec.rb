require 'spec_helper'

describe ItemsController do

  let(:category) { Category.create(name: 'foo') }
  let(:item) { Item.create(name: 'foo', description: 'bar') }

  describe 'GET #index' do
    it 'responds successfully with HTTP 200 status' do
      get :index, category_id: category
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with HTTP 200 status' do
      get :show, id: item, category_id: category 
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #edit' do
    it 'responds successfully with HTTP 200 status' do
      item = Item.create(name: 'foo', description: 'bar')
      get :edit, id: item, category_id: category 
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'POST #create' do
    it 'responds successfull 302 redirect' do
      post :create, item: { name: 'foo', description: 'bar', category_id: :category }, category_id: category
      expect(response).to redirect_to(category_item_url(assigns(:category), assigns(:item)))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Item was successfully created.') 
    end
  end

  describe 'PATCH/PUT #update' do
    it 'should update the record and redirect successfully for PATCH' do
      patch :update,  id: item, category_id: category, item: { name: 'changed foo', description: 'changed bar' }
      expect(response).to redirect_to(category_item_url(assigns(:category), assigns(:item)))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Item was successfully updated.') 
    end

    it 'should update the record and redirect successfully for PATCH' do
      put :update,  id: item, category_id: category, item: { name: 'changed foo', description: 'changed bar' }
      expect(response).to redirect_to(category_item_url(assigns(:category), assigns(:item)))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Item was successfully updated.') 
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the record and redirect successfully' do
      delete :destroy, id: item, category_id: category
      expect(response).to redirect_to(category_items_url)
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Item was successfully destroyed.') 
    end
  end

end
