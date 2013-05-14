require 'spec_helper'

describe CategoriesController do
  describe 'GET #index' do
    it 'responds successfully with HTTP 200 status' do
      get :index 
      expect(response).to be_success
      expect(response.status).to eql(200)
      assigns(:categories).should == Category.all
    end
  end

  describe 'GET #show' do
    it 'responds successfully with HTTP 200 status' do
      @category = Category.create(name: 'Technology')
      get :show, id: @category
      expect(response).to be_success
      expect(response.status).to eql(200)
    end

    it 'sets the correct variables' do
      @category = Category.create(name: 'Technology')
      Item.create!(name: 'foo', description: 'bar', category_id: @category)
      get :show, id: @category
      assigns(:items).should == Item.where(category_id: assigns(:category))
    end

  end

  describe 'GET #edit' do
    it 'responds successfully with HTTP 200 status' do
      @category = Category.create(name: 'Technology')
      get :edit, id: @category
      expect(response).to be_success
      expect(response.status).to eql(200)
    end
  end

  describe 'POST #create' do
    it 'responds successfull 302 redirect' do
      post :create, category: { name: 'Technology' }
      expect(response).to redirect_to(assigns(:category))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Category was successfully created.') 
    end
  end

  describe 'PATCH/PUT #update' do
    it 'should update the record and redirect successfully for PATCH' do
      @category = Category.create(name: 'Technology')
      patch :update, id: @category, category: { name: 'Technology' }
      expect(response).to redirect_to(assigns(:category))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Category was successfully updated.') 
    end

    it 'should update the record and redirect successfully for POST' do
      @category = Category.create(name: 'Technology')
      put :update, id: @category, category: { name: 'Technology' }
      expect(response).to redirect_to(assigns(:category))
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Category was successfully updated.') 
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the record and redirect successfully' do
      @category = Category.create(name: 'Technology')
      delete :destroy, id: @category 
      expect(response).to redirect_to(categories_url)
      expect(response.status).to eql(302)
      expect(flash[:notice]).to eql('Category was successfully destroyed.') 
    end
  end

  describe 'Mass Assignment Protection' do
    let(:category) { Category.create(name: 'Technology') }

    it 'only allows the correct params to pass to model' do
      time = Time.now
      patch :update, id: category.to_param, category: { 'name' => 'Other', 'created_at' => "#{time}" }

      assigns(:category).name.should eql('Other')
      assigns(:category).created_at.should_not == time
    end
  end


end
