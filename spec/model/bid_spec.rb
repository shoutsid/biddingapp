require 'spec_helper'

describe Bid do
  it { should belong_to(:user) }
  it { should belong_to(:item) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }

  describe 'Custom Validation' do
    describe '#item_expired' do
      context 'not valid' do
        it "adds an error" do
          item = FactoryGirl.create(:item, closing_time: Time.now - 2.hours)
          bid = FactoryGirl.build(:bid, item: item)
          bid.valid?
          bid.errors[:item].should include "Can't bid on an expired item."
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
