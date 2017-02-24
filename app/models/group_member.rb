class GroupMember < ApplicationRecord
  belongs_to :team, -> {where group_type: Team.group_types[:team]}
  belongs_to :organization, -> {where group_type: Organization.group_types[:organization]}
  belongs_to :user

  scope :team_user, ->{where group_type: Team.group_types[:team]}
  scope :organization_user, ->{where group_type: Organization.group_types[:organization]}
  scope :member, ->{where confirm: true}
  scope :request, ->{where confirm: false}
end
