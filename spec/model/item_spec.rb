require 'spec_helper'

describe Item do
  it { should belong_to(:category) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:starting_price) }
  it { should validate_presence_of(:closing_time) }
  it { should have_many(:bids) }

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

  describe 'check_time_left' do
    it 'returns as an integer' do
      item = FactoryGirl.create(:item)
      item.check_time_left.should be_kind_of(Integer)
    end

    it 'returns correct time left in seconds' do
      item = FactoryGirl.create(:item, closing_time: Time.now + 1.hour)
      item.check_time_left.should eql(1.hour.to_i)
    end
  end
end
