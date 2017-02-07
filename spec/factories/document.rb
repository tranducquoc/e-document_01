FactoryGirl.define do
  factory :document do
    name{FFaker::Book.title}
    description{FFaker::Lorem.words}
    category_id {Category.select("id").sample().id}
    user_id {User.select("id").sample().id}
  end
end
