require 'spec_helper'

describe BidsController do
 before(:each) { @bid = FactoryGirl.create(:bid) }

  describe 'GET #index' do
    let(:send_request) do 
      @item = @bid.item
      @category = @item.category
      get :index, item_id: @item, category_id: @category 
    end

    it 'should be successfull' do
      send_request
      expect(response).to be_success
    end

    it 'responds with HTTP 200 status' do
      send_request
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #show' do
    let(:send_request) do 
      @item = @bid.item
      @category = @item.category
      get :show, id: @bid, item_id: @item, category_id: @category
    end

    it 'responds successfull' do
      send_request
      expect(response).to be_success
    end
    it 'responds with HTTP 200 status' do
      send_request
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #edit' do
    let(:send_request) do
      @item = @bid.item
      @category = @item.category
      get :edit, id: @bid, item_id: @item, category_id: @category
    end

    it 'responds successfull' do
      send_request
      expect(response).to be_success
    end
    it 'responds with HTTP 200 status' do
      send_request
      expect(response.status).to eql(200)
    end 
  end

  describe 'POST #create' do
    context 'bid is higher than previous' do
      let(:send_request) {
        @item = @bid.item 
        @category = @item.category
        post :create, item_id: @item, category_id: @category, bid: { amount: 10, item_id: @item } 
        post :create, item_id: @item, category_id: @category, bid: { amount: 5000, item_id: @item } 
      }

      it 'should create a new record' do
        @item = @bid.item
        @category = @item.category
        lambda {
          post :create, item_id: @item, category_id: @category, bid: { amount: 5000, item_id: @item } 
        }.should change(Bid, :count).by(1) 
      end

      it 'responds as a redirect' do
        send_request
        expect(response).to be_redirect
      end

      it 'redirects to correct url' do
        send_request
        expect(response).to redirect_to(category_item_url(assigns(:category), assigns(:item)))
      end

      it 'responds with HTTP 302 status' do
        send_request
        expect(response.status).to eql(302)
      end

      it 'should set flash notice' do
        send_request
        expect(flash[:notice]).to eql('Bid was successfully created.') 
      end
    end

    context 'when bid is lower than previous' do
      let(:send_request) {
        @item = @bid.item
        @category = @item.category
        post :create, item_id: @item, category_id: @category, bid: { amount: 5000, item_id: @item } 
        post :create, item_id: @item, category_id: @category, bid: { amount: 10, item_id: @item } 
      }

      it 'should not create a new record' do
        @item = @bid.item
        @category = @item.category
        post :create, item_id: @item, category_id: @category, bid: { amount: 5000 } 
        lambda { 
          post :create, item_id: @item, category_id: @category, bid: { amount: 10, item_id: @item } 
        }.should_not change(Bid, :count).by(1) 
      end      

      it 'does not redirect to successful url' do
        send_request
        expect(response).to_not redirect_to(category_item_bids_url(assigns(:category), assigns(:item)))
      end

      it 'responds with 200 HTTP status' do
        send_request
        expect(response.status).to eql(200)
      end
      it 'renders the new template' do
        send_request
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PATCH/PUT #update' do
    let(:send_put_request) do
      @item = @bid.item
      @category = @item.category
      put :update, id: @bid, item_id: @item, category_id: @category, bid: { amount: 5000 }
    end

    let(:send_patch_request) do
      @item = @bid.item
      @category = @item.category
      patch :update, id: @bid, item_id: @item, category_id: @category, bid: { amount: 5000 }
    end

    context 'Using the PATCH HTTP Method' do
      context 'given correct params' do

        it 'should update the record' do
          @item = @bid.item
          @category = @item.category
          patch :update, id: @bid, item_id: @item, category_id: @category, bid: { amount: 5000 }
          Bid.find(@bid).amount.should eql(5000.to_d)
        end

        it 'responds as redirect' do
          send_patch_request
          expect(response).to be_redirect
        end

        it 'redirects to the correct url' do
          send_patch_request
          expect(response).to redirect_to(category_item_bids_url(assigns(:category), assigns(:item)))
        end

        it 'responds with 302 redirect status' do
          send_patch_request
          expect(response.status).to eql(302)
        end

        it 'sets correct flash notice' do
          send_patch_request
          expect(flash[:notice]).to eql('Bid was successfully updated.') 
        end
      end
    end

    context 'Using the PUT HTTP Method' do
      context 'given correct params' do

        it 'should update the record' do
          @item = @bid.item
          @category = @item.category
          put :update, id: @bid, item_id: @item, category_id: @category, bid: { amount: 5000 }
          Bid.find(@bid).amount.should eql(5000.to_d)
        end

        it 'responds as redirect' do
          send_put_request
          expect(response).to be_redirect
        end

        it 'redirects to the correct url' do
          send_put_request
          expect(response).to redirect_to(category_item_bids_url(assigns(:category), assigns(:item)))
        end

        it 'responds with 302 redirect status' do
          send_put_request
          expect(response.status).to eql(302)
        end

        it 'sets correct flash notice' do
          send_put_request
          expect(flash[:notice]).to eql('Bid was successfully updated.') 
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:send_request) do
      @item = @bid.item
      @category = @item.category
      delete :destroy, item_id: @item, id: @bid, category_id: @category
    end

    it 'should create a delete record' do
      @item = @bid.item
      @category = @item.category
      lambda { delete :destroy, item_id: @item, id: @bid, category_id: @category }.should change(Bid, :count).by(-1)
    end

    it 'responds as redirect' do
      send_request
      expect(response).to be_redirect
    end

    it 'redirects to the correct url' do
      send_request
      expect(response).to redirect_to(category_item_bids_url)
    end

    it 'responds with 302 redirect status' do
      send_request
      expect(response.status).to eql(302)
    end
    it 'sets the correct flash notice' do
      send_request
      expect(flash[:notice]).to eql('Bid was successfully destroyed.') 
    end
  end
end
