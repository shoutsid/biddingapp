require 'spec_helper'

describe Admin::CategoriesController do
  before(:each) { @category = FactoryGirl.create(:category)
    @admin = FactoryGirl.create(:admin)
    sign_in :admin, @admin
  }

  describe 'GET #edit' do
    let(:send_request) { get :edit, id: @category }

    it 'responds succesfull'do
      send_request
      expect(response).to be_success
    end

    it 'responds with 200 status' do
      send_request
      expect(response.status).to eql(200)
    end
  end

  describe 'POST #create' do
    let(:send_request) { post :create, category: { name: 'foobar' } }

    it 'creates a new record' do
      lambda { post :create, category: { name: 'Techbology' } }.should change(Category, :count).by(1)
    end

    it 'responds as redirect' do
      send_request
      expect(response).to be_redirect
    end

    it 'redirects to the correct url' do
      send_request
      expect(response).to redirect_to(assigns(:category))
    end

    it 'responds with 302 redirect status' do
      send_request
      expect(response.status).to eql(302)
    end

    it 'sets the correct flash notice' do
      send_request
      expect(flash[:notice]).to eql('Category was successfully created.')
    end
  end

  describe 'PATCH/PUT #update' do
    let(:send_patch_request) { patch :update, id: @category, category: { name: 'Technology' } }
    let(:send_put_request) { put :update, id: @category, category: { name: 'Technology' } }

    context 'HTTP PATCH method' do
      it 'updates the @category' do
        patch :update, id: @category, category: { name: 'changed' }
        Category.find(@category).name.should eql('changed')
      end

      it 'responds as redirect' do
        send_patch_request
        expect(response).to be_redirect
      end

      it 'redirects to the correct url' do
        send_patch_request
        expect(response).to redirect_to(assigns(:category))
      end

      it 'responds with 302 redirect status' do
        send_patch_request
        expect(response.status).to eql(302)
      end

      it 'sets the correct flash notice' do
        send_patch_request
        expect(flash[:notice]).to eql('Category was successfully updated.')
      end
    end

    context 'HTTP PUT method' do
      it 'updates the @category' do
        put :update, id: @category, category: { name: 'changed' }
        Category.find(@category).name.should eql('changed')
      end

      it 'responds as redirect' do
        send_put_request
        expect(response).to be_redirect
      end

      it 'redirects to the correct url' do
        send_put_request
        expect(response).to redirect_to(assigns(:category))
      end

      it 'responds with 302 redirect status' do
        send_put_request
        expect(response.status).to eql(302)
      end

      it 'sets the correct flash notice' do
        send_put_request
        expect(flash[:notice]).to eql('Category was successfully updated.')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:send_request) { delete :destroy, id: @category }

    it 'should delete the record' do
      lambda{ delete :destroy, id: @category }.should change(Category, :count).by(-1)
    end

    it 'respond as redirect' do
      send_request
      expect(response).to be_redirect
    end

    it 'redirects to the correct url' do
      send_request
      expect(response).to redirect_to(categories_url)
    end

    it 'responds with 302 redirect status' do
      send_request
      expect(response.status).to eql(302)
    end

    it 'sets the correct flash notice' do
      send_request
      expect(flash[:notice]).to eql('Category was successfully destroyed.')
    end
  end
end
