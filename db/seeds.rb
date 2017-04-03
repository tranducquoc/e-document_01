User.create!(name: "Framgia Admin",
  email: "framgia.document@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  role: :admin)

user_hash = {
  "Taihei Kobayashi": "taihei.kobayashi",
  "Chu Anh Tuan": "chu.anh.tuan",
  "Nguyen Binh Dieu": "nguyen.binh.dieu",
  "Hoang Thi Nhung": "hoang.thi.nhung",
  "Tran Xuan Thang": "tran.xuan.thang",
  "Bui Minh Thai": "bui.minh.thai",
  "Vu Anh Tuan B": "vu.anh.tuanb",
  "Luu Thi Thom": "luu.thi.thom",
  "Tao Thi Luyen": "tao.thi.luyen",
  "Nguyen Van Thanh C": "nguyen.van.thanhc",
  "Nguyen Quang Vinh": "nguyen.quang.vinh"
}

user_hash.each do |key, value|
  User.create!(name: key, email: value + "@framgia.com", password: "123456",
    password_confirmation: "123456",
    role: :member)
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

Organization.create!(name: "Framgia Vietnam",
 description: "We make IT Awesome")
Organization.create!(name: "Framgia Education",
 description: "From Asia To The World")

Team.create!(name: "Ruby Developer", organization_id: 1)
Team.create!(name: "Trainer", organization_id: 2)
Team.create!(name: "FEDS", organization_id: 2)
Team.create!(name: "FCSP", organization_id: 2)
Team.create!(name: "CV Maker", organization_id: 2)

GroupMember.create!(user_id: 1, group_id: 1, group_type: "organization", role: "admin", confirm: true)
GroupMember.create!(user_id: 3, group_id: 2, group_type: "organization", role: "admin", confirm: true)

GroupMember.create!(user_id: 4, group_id: 1, group_type: "team", role: "admin", confirm: true)
GroupMember.create!(user_id: 4, group_id: 2, group_type: "team", role: "admin", confirm: true)
GroupMember.create!(user_id: 5, group_id: 3, group_type: "team", role: "admin", confirm: true)
GroupMember.create!(user_id: 5, group_id: 4, group_type: "team", role: "admin", confirm: true)
GroupMember.create!(user_id: 5, group_id: 5, group_type: "team", role: "admin", confirm: true)

GroupMember.create!(user_id: 3, group_id: 1, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 4, group_id: 1, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 5, group_id: 1, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 4, group_id: 2, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 5, group_id: 2, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 6, group_id: 2, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 7, group_id: 2, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 8, group_id: 2, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 9, group_id: 2, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 10, group_id: 2, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 10, group_id: 2, group_type: "organization", role: "member", confirm: true)
GroupMember.create!(user_id: 10, group_id: 2, group_type: "organization", role: "member", confirm: true)

GroupMember.create!(user_id: 5, group_id: 2, group_type: "team", role: "member", confirm: true)
GroupMember.create!(user_id: 6, group_id: 2, group_type: "team", role: "member", confirm: true)

Serie.create!(name: "Framgia Policy", user_id: 2, organization_id: 1)
