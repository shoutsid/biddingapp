require 'spec_helper'

describe User do
  it { should have_many(:bids) }
  it { should have_many(:items) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }

  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:street_number) }
  it { should validate_presence_of(:postal_code) }
  it { should validate_presence_of(:country) }
end
