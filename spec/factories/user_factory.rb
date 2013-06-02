FactoryGirl.define do

  sequence(:username) { |n| "user#{n}" }
  sequence(:email) { |n| "foo#{n}@gmail.com" }
  sequence(:address) { |n| "#{n} example, NY, 10001" }
  sequence(:postal_code) { |n| "1000#{n}" }
  sequence(:street_number) { |n| "#{n}" }

  factory :user do
    username { generate(:username) }
    email { generate(:email) }
    password 'password'
    balance 100000
    address { generate(:address) }
    street_number { generate(:street_number) }
    postal_code { generate(:postal_code) }
    country 'United States'
  end
end
