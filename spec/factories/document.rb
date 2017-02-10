FactoryGirl.define do
  factory :document do
    name{FFaker::Book.title}
    description{FFaker::Lorem.words}
    category_id {Category.first.id}
    user_id {User.first.id}
  end
end
