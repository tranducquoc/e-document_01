FactoryGirl.define do
  factory :chatroom do
    title{FFaker::Book.title}
    host_id{User.first.id}
    guest_id{User.last.id}
  end
end
