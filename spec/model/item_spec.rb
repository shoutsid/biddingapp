require 'spec_helper'

describe Item do
  it { should belong_to(:category) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:starting_price) }
  it { should validate_presence_of(:closing_time) }
  it { should have_many(:bids) }
end
