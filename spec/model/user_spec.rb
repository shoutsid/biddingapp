require 'spec_helper'

describe User do
  it { should have_many(:bids) }
  it { should have_many(:items) }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:street_number) }
  it { should validate_presence_of(:postal_code) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username) }

  describe '#hard_update_balance' do
    context 'when given amount to reset balance too' do
      it 'resets balance to amount supplied' do
        user = FactoryGirl.create(:user)
        user.hard_reset_balance(20)
        User.find(user).balance.should eql(20.to_d)
      end

      context 'when no amount supplied' do
        it 'resets balance to 0' do
          user = FactoryGirl.create(:user, balance: 20)
          user.hard_reset_balance
          User.find(user).balance.should eql(0.to_d)
        end
      end
    end
  end

  describe '#update_user_balance_by' do
    context 'given positive amount' do
      it 'increases balance by given amount' do
        user = FactoryGirl.create(:user, balance: 20)
        user.update_user_balance_by(10)
        User.find(user).balance.should eql(30.to_d)
      end
    end

    context 'given negitive amount' do
      it 'decreases balance by given amount' do
        user = FactoryGirl.create(:user, balance: 20)
        user.update_user_balance_by(-10)
        User.find(user).balance.should eql(10.to_d)
      end
    end
  end

  describe '#has_enough_balance_to_bid?' do
    context 'user has enough balance' do
      it 'returns true' do
        user = FactoryGirl.create(:user, balance: 9000)
        user.has_enough_balance_to_bid?(200).should eql(true)
      end
    end

    context 'user doesnt have enough balance' do
      it 'returns false' do
        user = FactoryGirl.create(:user, balance: 20)
        user.has_enough_balance_to_bid?(200).should eql(false)
      end
    end
  end

  describe '#not_sold_item_count' do
    it 'returns correct count' do
      user = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item, user: user)
      item.closed = true
      item.sold = false
      item.save
      User.find(user).not_sold_item_count.should eql(1)
    end
  end

  describe '#sold_item_count' do
    it 'returns correct count' do
      user = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item, user: user)
      item.sold = true
      item.closed = true
      item.save
      User.find(user).sold_item_count.should eql(1)
    end
  end

  describe '#closed_item_count' do
    it 'returns correct count' do
      user = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item, user: user)
      item.closed = true
      item.save
      User.find(user).closed_item_count.should eql(1)
    end
  end

  describe '#not_closed_item_count' do
    it 'returns correct count' do
      user = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item, user: user)
      User.find(user).not_closed_item_count.should eql(1)
    end
  end
end
