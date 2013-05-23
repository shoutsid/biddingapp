FactoryGirl.define do

  sequence(:email) { |n| "foo#{n}@gmail.com" }
  sequence(:address) { |n| "#{n} example, NY, 10001" }
  sequence(:postal_code) { |n| "1000#{n}" }
  sequence(:street_number) { |n| "foo#{n}@gmail.com" }
  sequence(:country) { |n| "United States" }

  factory :user do
    email 
    password 'password'
    address
    street_number
    postal_code
    country
  end
end
