require "ffaker"

FactoryGirl.define do
  factory :buycoin do
    user_id{User.select("id").sample().id}
    coin_id{Coin.select("id").sample().id}
  end
end
