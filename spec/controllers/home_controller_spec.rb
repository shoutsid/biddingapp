require 'spec_helper'

describe HomeController do
  before(:each) {
    @user = FactoryGirl.create(:user)
    sign_in :user, @user
  }

  describe 'GET #index' do
    let(:send_request) { get :index }

    it 'responds succesfull' do
      send_request
      expect(response).to be_success
    end

    it 'responds with 200 status' do
      send_request
      expect(response.status).to eql(200)
    end
  end
end
