FactoryGirl.define do
  sequence(:item_name) { |n| "CPU#{n}" }

  factory :item do
    name { generate(:item_name) }
    description 'foo'
    category
    user
    starting_price 100
    min_accept_bid 101
    closing_time Time.now + 1.day
  end
end
