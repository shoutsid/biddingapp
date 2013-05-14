require 'spec_helper'

describe BidsController do
  let(:category) { Category.create!(name: 'Art') }
  let(:item) { Item.create!(name: 'foo', description: 'bar', category_id: category.id, starting_price: 10) }
  let(:user) { User.create(password: 'password', email: 'foo@example.com') }
  let(:bid) { Bid.create!(price: 1000, user_id: user.id, item_id: item.id) }

  describe 'GET #index' do

    it 'should be successfull' do
      get :index, item_id: item, category_id: category
      expect(response).to be_success
    end
    it 'responds with HTTP 200 status' do
      get :index, item_id: item, category_id: category
      expect(response.status).to eql(200)
    end
  end

  describe 'GET #show' do
    let(:send_request){ get :show, id: bid, item_id: item, category_id: category }

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
    let(:send_request) { get :edit, id: bid, item_id: item, category_id: category }

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
      let(:send_request) { post :create, item_id: item.id, category_id: category.id, bid: { price: 5000, item_id: item } }

      it 'should create a new record' do
        lambda { post :create, item_id: item.id, category_id: category.id, bid: { price: 5000, item_id: item } }.should change(Bid, :count).by(1) 
      end

      it 'responds as a redirect' do
        send_request
        expect(response).to be_redirect
      end

      it 'redirects to correct url' do
        send_request
        expect(response).to redirect_to(category_item_bids_url(assigns(:category), assigns(:item)))
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
      let(:send_request) do
        post :create, item_id: item.id, category_id: category.id, bid: { price: 2000 } 
        post :create, item_id: item.id, category_id: category.id, bid: { price: 10 } 
      end

      it 'should not create a new record' do
        post :create, item_id: item.id, category_id: category.id, bid: { price: 2000 } 
        lambda { post :create, item_id: item.id, category_id: category.id, bid: { price: 10, item_id: item } }.should_not change(Bid, :count).by(1) 
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
      @bid = bid
      put :update, id: @bid.id, item_id: item.id, category_id: category.id, bid: { price: 5000 }
    end

    let(:send_patch_request) do 
      @bid = bid
      patch :update, id: @bid.id, item_id: item.id, category_id: category.id, bid: { price: 5000 }
    end

    context 'Using the PATCH HTTP Method' do
      context 'given correct params' do

        it 'should update the record' do
          send_patch_request
          Bid.find(@bid).price.should eql(5000.to_d)
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
          send_put_request
          Bid.find(@bid).price.should eql(5000.to_d)
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
    let(:send_request) { delete :destroy, item_id: item, id: bid, category_id: category }

    it 'should create a delete record' do
      @bid = bid 
      @item = @bid.item
      @category = @bid.item.category
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
