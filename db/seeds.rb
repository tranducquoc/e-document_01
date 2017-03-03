User.create!(name: "Framgia Admin",
  email: "framgia.document@gmail.com",
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
User.create!(name: "thaibm",
  email: "thaibm.uet@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :member)
User.create!(name: "tuan",
  email: "tuan@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :member)
User.create!(name: "test1",
  email: "test1@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :member)
User.create!(name: "test2",
  email: "test2@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :member)
User.create!(name: "test3",
  email: "test3@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :member)

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

Category.create!(name: "Ruby on Rails")
Category.create!(name: "Android")
Category.create!(name: "IOS")
Category.create!(name: "Java")
Category.create!(name: "Natural Language Processing")

# 5.times do |n|
#   name = FFaker::Name.name
#   Category.create!(name: name)
# end

# 20.times do |n|
#   name = "Document-#{n}"
#   category_id = rand(Category.all.size) + 1
#   user_id = rand(User.all.size) + 1
#   Document.create!(name: name,
#     category_id: category_id,
#     user_id: user_id, status: :checked)
# end

Organization.create!(name: "Framgia 1")
Organization.create!(name: "Framgia 2")
Organization.create!(name: "Framgia 3")
Organization.create!(name: "Framgia 4")

Team.create!(name: "Team1", organization_id: 4)
Team.create!(name: "Team2", organization_id: 4)
Team.create!(name: "Team3", organization_id: 4)
Team.create!(name: "Team4", organization_id: 4)
Team.create!(name: "Team5", organization_id: 4)

GroupMember.create!(user_id: 1, group_id: 1, group_type: "organization", role: "admin", confirm: true)
GroupMember.create!(user_id: 1, group_id: 2, group_type: "organization", role: "admin", confirm: true)
GroupMember.create!(user_id: 1, group_id: 3, group_type: "organization", role: "admin", confirm: true)
GroupMember.create!(user_id: 4, group_id: 4, group_type: "organization", role: "admin", confirm: true)
GroupMember.create!(user_id: 5, group_id: 4, group_type: "organization", role: "admin", confirm: true)

GroupMember.create!(user_id: 6, group_id: 4, group_type: "organization", role: "member", confirm: false)
GroupMember.create!(user_id: 7, group_id: 4, group_type: "organization", role: "member", confirm: false)
GroupMember.create!(user_id: 8, group_id: 4, group_type: "organization", role: "member", confirm: false)

GroupMember.create!(user_id: 5, group_id: 1, group_type: "team", role: "admin", confirm: true)
GroupMember.create!(user_id: 5, group_id: 2, group_type: "team", role: "admin", confirm: true)
GroupMember.create!(user_id: 5, group_id: 3, group_type: "team", role: "admin", confirm: true)
GroupMember.create!(user_id: 5, group_id: 4, group_type: "team", role: "admin", confirm: true)
GroupMember.create!(user_id: 5, group_id: 5, group_type: "team", role: "admin", confirm: true)

GroupMember.create!(user_id: 2, group_id: 1, group_type: "team", role: "member", confirm: false)
GroupMember.create!(user_id: 3, group_id: 1, group_type: "team", role: "member", confirm: false)
GroupMember.create!(user_id: 6, group_id: 1, group_type: "team", role: "member", confirm: false)
