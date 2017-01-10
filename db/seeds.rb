10.times do |n|
  name = Faker::Name.name
  Category.create!(name: name)
end

10.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@gmail.com"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
