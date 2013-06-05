require 'spec_helper'

describe CategoriesController do
  before(:each) { @category = FactoryGirl.create(:category) }

  describe 'GET #show' do
    let(:send_request) { get :show, id: @category }

    it 'responds succesfull'do
      send_request
      expect(response).to be_success
    end

    it 'responds with 200 status' do
      send_request
      expect(response.status).to eql(200)
    end
  end
end
