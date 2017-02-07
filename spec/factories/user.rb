require "ffaker"

FactoryGirl.define do
  factory :user do
    name{FFaker::Name.name}
    email{FFaker::Internet.email}
    phone_number{FFaker::PhoneNumber.phone_number}
    password "password"
    password_confirmation "password"
    last_sign_in_at "2017-01-07 06:21:10.460110"
  end

  trait :admin do
    role{User.role[:admin]}
  end
end
