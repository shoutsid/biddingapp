FactoryGirl.define do

  sequence(:email) { |n| "foo#{n}@gmail.com" }

  factory :user do
    email 
    password 'password'
  end
end
