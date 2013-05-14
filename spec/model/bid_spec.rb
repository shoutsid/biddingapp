require 'spec_helper'

describe Bid do
  it { should belong_to(:user) }
  it { should belong_to(:item) }
  it { should validate_numericality_of(:price) }
end
