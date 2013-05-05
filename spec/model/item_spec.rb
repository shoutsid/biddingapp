require 'spec_helper'

describe Item do
  it { should belong_to(:category) }
  it { should belong_to(:user) }
end
