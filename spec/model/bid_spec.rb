require 'spec_helper'

describe Bid do
  it { should belong_to(:user) }
  it { should belong_to(:item) }
end
