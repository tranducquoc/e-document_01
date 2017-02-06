require "ffaker"

FactoryGirl.define do
  factory :user do
    name{FFaker::Name.name}
    email{FFaker::Internet.email}
    phone_number{FFaker::PhoneNumber.phone_number}
    password "123456"
    password_confirmation "123456"
  end

  trait :admin do
    role{User.role[:admin]}
  end
end
