FactoryGirl.define do
  factory :coin do
    code{"code-1"}
    value{10}
    user_id {User.first.id}
  end
end
