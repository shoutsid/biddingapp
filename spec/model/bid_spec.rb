require 'spec_helper'

describe Bid do
  it { should belong_to(:user) }
  it { should belong_to(:item) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }

  describe 'Custom Validation' do
    describe '#item_expired' do
      context 'Item has expired' do
        it 'adds an error' do
          item = FactoryGirl.create(:item, closing_time: Time.now - 2.hours)
          bid = FactoryGirl.build(:bid, item: item)
          bid.valid?
          bid.errors[:item].should include "Can't bid on an expired item."
        end
      end

      context 'Item has not expired' do
        it 'should pass' do
          item = FactoryGirl.create(:item, closing_time: Time.now + 2.hours)
          bid = FactoryGirl.build(:bid, item: item)
          bid.valid?.should eql(true)
        end
      end
    end

    describe '#has_enough_balance?' do
      context 'bid user does not have enough balance' do
        it 'adds an error' do
          user = FactoryGirl.create(:user, balance: 1000)
          bid = FactoryGirl.build(:bid, user: user, amount: 3000)
          bid.valid?
          bid.errors[:amount].should include "You do not have enough balance to make that bid."
        end
      end

      context 'bid user has enough balance' do
        it 'returns true' do
          user = FactoryGirl.create(:user, balance: 9000)
          bid = FactoryGirl.build(:bid, user: user, amount: 3000)
          bid.valid?.should eql(true)
        end
      end
    end
  end

  describe '#bump_item_time_let' do
    context 'after create' do
      it 'bumps time left on parent item' do
        item = FactoryGirl.create(:item, closing_time: Time.now + 2.hours)
        bid = FactoryGirl.create(:bid, item: item)
        bid.item.time_left.should eql('02:00:10')
      end
    end
  end

  describe '#deduct_from_balance' do
    it 'should deduct bid amount from users balance' do
      user = FactoryGirl.create(:user, balance: 2000)
      bid = FactoryGirl.create(:bid, user: user, amount: 900)
      User.find(user).balance.should eql(1100.to_d) 
    end
  end

  describe '#reimberse_previous_bidders_balance' do
    it 'should reimberse previous balance to correct amount' do
      item = FactoryGirl.create(:item)
      user_1 = FactoryGirl.create(:user, balance: 5000)
      user_2 = FactoryGirl.create(:user, balance: 5000)
      user_bid_1 = FactoryGirl.create(:bid, user: user_1, amount: 900, item: item)
      user_bid_2 = FactoryGirl.create(:bid, user: user_2, amount: 1000, item: item)
      User.find(user_1).balance.should eql(5000.to_d) 
    end
  end

end
