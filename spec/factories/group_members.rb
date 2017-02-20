FactoryGirl.define do
  factory :group_member do
    user_id 1
    group_id 1
    group_type "MyString"
    role "MyString"
    confirm ""
  end
end
