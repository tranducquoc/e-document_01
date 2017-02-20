class GroupMember < ApplicationRecord
  belongs_to :team, -> {where group_type: "team"}
  belongs_to :organization, -> {where group_type: "organization"}
  belongs_to :user
end
