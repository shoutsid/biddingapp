require 'spec_helper'

describe ItemsController do
  describe 'GET #index' do
    it 'responds successfully with HTTP 200 status' do
      get :index
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #show' do
    it 'responds successfully with HTTP 200 status' do
      item = Item.create(name: 'foo', description: 'bar')
      get :show, id: item 
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #edit' do
    it 'responds successfully with HTTP 200 status' do
      item = Item.create(name: 'foo', description: 'bar')
      get :edit, id: item 
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'POST #create' do
    it 'responds successfull 302 redirect' do
      post :create, item: {name: 'foo', description: 'bar'}
      expect(response).to redirect_to(assigns(:item))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Item was successfully created.') 
    end
  end

  describe 'PATCH/PUT #update' do
    it 'should update the record and redirect successfully for PATCH' do
      item = Item.create(name: 'foo', description: 'bar')
      patch :update,  id: item, item: { name: 'changed foo', description: 'changed bar' }
      expect(response).to redirect_to(assigns(:item))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Item was successfully updated.') 
    end

    it 'should update the record and redirect successfully for PATCH' do
      item = Item.create(name: 'foo', description: 'bar')
      put :update,  id: item, item: { name: 'changed foo', description: 'changed bar' }
      expect(response).to redirect_to(assigns(:item))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Item was successfully updated.') 
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the record and redirect successfully' do
      item = Item.create(name: 'foo', description: 'bar')
      delete :destroy, id: item
      expect(response).to redirect_to(items_path)
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Item was successfully destroyed.') 
    end
  end

end
