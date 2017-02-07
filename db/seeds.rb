User.create!(name: "buiquyhoat",
  email: "buiquyhoat@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :admin)
User.create!(name: "hoat",
  email: "buiquyhoat1@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :member)
User.create!(name: "tuanh",
  email: "letuanh821993@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :member)
20.times do |n|
  name  = "name-#{n + 1}"
  email = "example-#{n + 1}@gmail.com"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end

10.times do |n|
  code  = "code-#{n + 1}"
  value = 10
  Coin.create!(code: code,
    value: value,
    status: :available)
end

10.times do |n|
  code  = "code-#{n + 11}"
  value = 20
  Coin.create!(code: code,
    value: value,
    status: :available)
end

10.times do |n|
  code  = "code-#{n + 22}"
  value = 30
  Coin.create!(code: code,
    value: value,
    status: :available)
end

5.times do |n|
  name = FFaker::Name.name
  Category.create!(name: name)
end

20.times do |n|
  name = "Document-#{n}"
  category_id = rand(Category.all.size) + 1
  user_id = rand(User.all.size) + 1
  Document.create!(name: name,
    category_id: category_id,
    user_id: user_id, status: :checked)
end

Relationship.create!(
  user_one_id: 1,
  user_two_id: 23)
