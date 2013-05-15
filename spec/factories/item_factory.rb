FactoryGirl.define do
  sequence(:item_name) { |n| "CPU#{n}" }

  factory :item do
    name :item_name
    description 'foo'
    category
    starting_price 100
    closing_time Time.now + 1.day
  end
end
