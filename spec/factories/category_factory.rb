FactoryGirl.define do
  sequence(:category_name) { |n| "Tech_#{n}" }

  factory :category do
    name { generate(:category_name) }
  end
end
