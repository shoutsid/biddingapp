require 'spec_helper'
describe ItemsController do

  before(:each) { @item = FactoryGirl.create(:item) }

  describe 'GET #index' do
    let(:send_request) { get :index, category_id: @item.category }

    it 'responds successful' do
      send_request
      expect(response).to be_success
    end

    it 'responds with 200 status' do
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #show' do
    let(:send_request) do
      @category = @item.category
      get :show, id: @item, category_id: @category 
    end

    it 'responds successful' do
      expect(response).to be_success
    end

    it 'responds with 200 status' do
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #edit' do
    let(:send_request) do
      @category = @item.category
      get :edit, id: @item, category_id: @category 
    end

    it 'responds successful' do
      expect(response).to be_success
    end

    it 'responds with 200 status' do
      expect(response.status).to eql(200)
    end

    describe 'POST #create' do
      let(:send_request) {
        @category = @item.category
        post :create, item: { name: 'foo', description: 'bar', category_id: @category, starting_price: 500, closing_time: Time.now + 1.day }, category_id: @category 
      }

      it 'creates a record' do
        @category = @item.category
        lambda{ post :create, item: { name: 'foo', description: 'bar', category_id: @category, starting_price: 500, closing_time: Time.now + 1.day }, category_id: @category 
        }.should change(Item, :count).by(1)
      end

      it 'responds as a redirect' do
        send_request
        expect(response).to be_redirect
      end

      it 'redirects to correct url' do
        send_request
        expect(response).to redirect_to(category_item_url(assigns(:category), assigns(:item)))
      end

      it 'responds with 302 redirect status' do
        send_request
        expect(response.status).to eql(302)
      end

      it 'sets the correct flash notice' do
        send_request
        expect(flash[:notice]).to eql('Item was successfully created.') 
      end
    end

    describe 'PATCH/PUT #update' do
      let(:send_patch_request) do 
        @category = @item.category
        patch :update,  id: @item, category_id: @category, item: { name: 'changed foo', description: 'changed bar', starting_price: 500, closing_time: Time.now + 1.day } 
      end

      let(:send_put_request) do 
        @category = @item.category
        put :update,  id: @item, category_id: @category, item: { name: 'changed foo', description: 'changed bar', starting_price: 500, closing_time: Time.now + 1.day } 
      end
      
      context 'PATCH HTTP method' do
        it 'should update the item' do
          @category = @item.category
          patch :update,  id: @item, category_id: @category, item: { name: 'changed foo', description: 'changed bar', starting_price: 500, closing_time: Time.now + 1.day }
          Item.find(@item).name.should eql('changed foo')
        end

        it 'responds as redirect' do
          send_patch_request
          expect(response).to be_redirect
        end

        it 'redirects to correct url' do
          send_patch_request
          expect(response).to redirect_to(category_item_url(assigns(:category), assigns(:item)))
        end

        it 'responds with 302 redirect status' do
          send_patch_request
          expect(response.status).to eql(302)
        end

        it 'sets correct flash notice' do
          send_patch_request
          expect(flash[:notice]).to eql('Item was successfully updated.') 
        end
      end

      context 'PUT HTTP method' do
        it 'should update the item' do
          @category = @item.category
          put :update,  id: @item, category_id: @category, item: { name: 'changed foo', description: 'changed bar', starting_price: 500, closing_time: Time.now + 1.day }
          Item.find(@item).name.should eql('changed foo')
        end

        it 'responds as redirect' do
          send_put_request
          expect(response).to be_redirect
        end

        it 'redirects to correct url' do
          send_put_request
          expect(response).to redirect_to(category_item_url(assigns(:category), assigns(:item)))
        end

        it 'responds with 302 redirect status' do
          send_put_request
          expect(response.status).to eql(302)
        end

        it 'sets correct flash notice' do
          send_put_request
          expect(flash[:notice]).to eql('Item was successfully updated.') 
        end
      end
    end

    describe 'DELETE #destroy' do
      let(:send_request) do 
        @category = @item.category
        delete :destroy, id: @item, category_id: @category
      end

      it 'deletes the record' do
        @category = @item.category
        lambda{ delete :destroy, id: @item, category_id: @category }.should change(Item, :count).by(-1)
      end

      it 'responds as redirect' do
        send_request
        expect(response).to be_redirect
      end

      it 'redirects to the correct url' do
        send_request
        expect(response).to redirect_to(category_items_url)
      end

      it 'responds with 302 redirect status' do
        send_request
        expect(response.status).to eql(302)
      end

      it 'sets the correct flash notice' do
        send_request
        expect(flash[:notice]).to eql('Item was successfully destroyed.') 
      end
    end
  end
end
