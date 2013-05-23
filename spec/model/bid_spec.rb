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
        item = FactoryGirl.create(:item)
        time_left = item.check_time_left
        bid = FactoryGirl.create(:bid, item: item)
        bid.item.check_time_left.should eql(time_left + 10.seconds)
      end
    end
  end

end
