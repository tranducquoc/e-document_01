class GroupMember < ApplicationRecord
  belongs_to :team, -> {where group_type: Team.group_types["team"]}
  belongs_to :organization, -> {where group_type: Organization.group_types["organization"]}
  belongs_to :user
end
