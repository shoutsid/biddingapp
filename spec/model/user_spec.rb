require 'spec_helper'

describe User do
  it { should have_many(:bids) }
  it { should have_many(:items) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
end
