FactoryGirl.define do

  factory :admin do
    email { generate(:email) }
    password 'password'
  end
end
