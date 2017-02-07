require "ffaker"

FactoryGirl.define do
  factory :read do
    document_id{Document.select("id").sample().id}
    user_id{User.first.id}
  end
end
