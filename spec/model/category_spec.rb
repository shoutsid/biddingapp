require 'spec_helper'

describe Category do
  it { should have_many(:items) }
  it { should validate_presence_of(:name) }

  it 'should override to_param to name url' do
    category = Category.create!(name: 'foo')
    category.to_param.should == category.url
  end
end
