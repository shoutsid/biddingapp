require 'spec_helper'

describe Bid do
  it { should belong_to(:user) }
  it { should belong_to(:item) }
  it { should validate_presence_of(:item) }
  it { should validate_presence_of(:amount) }
  it { should validate_numericality_of(:amount) }
end
