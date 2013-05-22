require 'spec_helper'

describe Item do
  it { should belong_to(:category) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:starting_price) }
  it { should validate_presence_of(:closing_time) }
  it { should validate_presence_of(:user) }
  it { should have_many(:bids) }

  describe '#not_closed' do
    context 'after create' do
      it 'sets closed to false' do
        item = FactoryGirl.create(:item)
        Item.find(item).closed.should eql(false)
      end
    end
  end

  describe '#highest_bid' do
    it 'returns highest bid' do
      item = FactoryGirl.create(:item)
      bid = FactoryGirl.create(:bid, item: item)
      Item.find(item).highest_bid.should eql(bid)
    end
  end

  describe '#time_left' do
    context 'there is time left' do
      it 'should give correct time left in seconds' do
        item = FactoryGirl.create(:item)
        item.time_left.should eql("Time left: " + item.check_time_left.to_s + " Seconds")
      end

      it 'returns type of string' do
        item = FactoryGirl.create(:item)
        item.time_left.should be_kind_of(String)
      end
    end

    context 'theres no time left' do
      it 'should return correct string' do
        item = FactoryGirl.create(:item, closing_time: Time.now - 2.hours)
        item.time_left.should eql("This Item Has Expired")
      end
    end
  end

  describe '#expired?' do
    context 'there is time left' do
      it 'returns false' do
        item = FactoryGirl.create(:item)
        item.expired?.should eql(false)
      end
    end

    context 'theres no time left' do
      it 'returns true' do
        item = FactoryGirl.create(:item, closing_time: Time.now - 2.hours)
        item.expired?.should eql(true)
      end
    end
  end

  describe '#increase_time_left' do
    it 'increased time left by 10 seconds' do
      item = FactoryGirl.create(:item)
      before_change = item.check_time_left
      item.increase_time_left
      Item.find(item).check_time_left.should eql(before_change + 10.seconds)
    end
  end

  describe '#check_time_left' do
    it 'returns as an integer' do
      item = FactoryGirl.create(:item)
      item.check_time_left.should be_kind_of(Integer)
    end

    it 'returns correct time left in seconds' do
      item = FactoryGirl.create(:item, closing_time: Time.now + 1.hour)
      item.check_time_left.should eql(1.hour.to_i)
    end
  end

  describe '#accept_highest_bid?' do
    context 'bid is above minimum accept price' do
      it 'should return true' do
        item = FactoryGirl.create(:item, starting_price: 10, min_accept_bid: 200)
        bid = FactoryGirl.create(:bid, item: item, amount: 1000)
        Item.find(item).accept_highest_bid?.should eql(true)
      end
    end

    context 'bid is below minimum accept price' do
      it 'should return false' do
        item = FactoryGirl.create(:item, starting_price: 10, min_accept_bid: 200)
        bid = FactoryGirl.create(:bid, item: item, amount: 20)
        Item.find(item).accept_highest_bid?.should eql(false)
      end
    end
  end

  describe '#min_bid_amount' do
    context 'no current bid' do
      it 'returns as big decimal' do
        item = FactoryGirl.create(:item, starting_price: 10, min_accept_bid: 200)
        Item.find(item).min_bid_amount.should be_kind_of(BigDecimal)
      end

      it 'returns item starting price + 1' do
        item = FactoryGirl.create(:item, starting_price: 10, min_accept_bid: 200)
        Item.find(item).min_bid_amount.should eql(11.to_d)
      end
    end

    context 'has highest bid' do
      it ' returns as a big decimal' do
        item = FactoryGirl.create(:item, starting_price: 10, min_accept_bid: 200)
        bid = FactoryGirl.create(:bid, item: item)
        Item.find(item).min_bid_amount.should be_kind_of(BigDecimal)
      end

      it 'returns highest bid + 1' do
        item = FactoryGirl.create(:item, starting_price: 10, min_accept_bid: 200)
        bid = FactoryGirl.create(:bid, item: item, amount: 200)
        Item.find(item).min_bid_amount.should eql(201.to_d)
      end
    end
  end

  describe '#close_auction' do
    context 'has expired expired' do
      context 'accepts the highest bid' do
        it 'sets item as closed, (true) value' do
          item = FactoryGirl.create(:item, closing_time: Time.now + 2.minutes)
          bid = FactoryGirl.create(:bid, item: item)
          item.update(closing_time: Time.now - 10.minutes)

          Item.find(item).close_auction
          Item.find(item).closed.should eql(true)
        end
      end

      context 'wont accept the highest bid' do
        it 'sets item as closed, (true) value' do
          item = FactoryGirl.create(:item, closing_time: Time.now - 2.minutes)
          Item.find(item).close_auction
          Item.find(item).closed.should eql(true)
        end
      end
    end
  end

  describe '#highest_bid_amount' do
    context 'no highest bid' do
      it 'should return 0' do
        item = FactoryGirl.create(:item, closing_time: Time.now - 2.minutes)
        Item.find(item).highest_bid_amount.should eql(0)
      end
    end

    context 'has highest bid' do
      it 'returns highest bid amount' do
        item = FactoryGirl.create(:item, closing_time: Time.now + 2.minutes)
        bid = FactoryGirl.create(:bid, item: item, amount: 500)
        Item.find(item).highest_bid_amount.should eql(500.to_d)
      end
    end
  end
end
