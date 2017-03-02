class GroupMember < ApplicationRecord
  belongs_to :user

  enum group_type: [:organization, :team]
  enum role: [:member, :admin]

  GroupMember.group_types.keys.each do |type|
    eval "belongs_to :#{type}, ->{where group_type: #{type}}"
    eval "scope :#{type}_user, ->{where group_type: #{type}}"
  end

  scope :admin, ->{where role: GroupMember.roles[:admin]}
  scope :member, ->{where confirm: true}
  scope :request, ->{where confirm: false}
end
