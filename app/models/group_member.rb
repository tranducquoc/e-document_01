class GroupMember < ApplicationRecord
  belongs_to :team, -> {where group_type: GroupMember.group_types[:team]}
  belongs_to :organization, -> {where group_type: GroupMember.group_types[:organization]}
  belongs_to :user

  enum group_type: [:organization, :team]
  enum role: [:member, :admin]

  scope :team_user, ->{where group_type: GroupMember.group_types[:team]}
  scope :organization_user, ->{where group_type: GroupMember.group_types[:organization]}
  scope :admin, ->{where role: GroupMember.roles[:admin]}
  scope :member, ->{where confirm: true}
  scope :request, ->{where confirm: false}
end
