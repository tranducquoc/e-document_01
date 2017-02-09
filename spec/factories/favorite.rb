FactoryGirl.define do
  factory :favorite do
    user_id{User.select("id").sample().id}
    document_id{Document.select("id").sample().id}
  end
end
