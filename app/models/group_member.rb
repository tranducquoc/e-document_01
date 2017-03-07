class GroupMember < ApplicationRecord
  belongs_to :user

  delegate :name, :email, :address, to: :user

  enum group_type: [:organization, :team]
  enum role: [:member, :admin]

  GroupMember.group_types.keys.each do |type|
    eval "belongs_to :#{type}, ->{where group_type: #{type}}"
  end

  scope :team_user, ->{where group_type: GroupMember.group_types[:team]}
  scope :organization_user, ->{where group_type: GroupMember.group_types[:organization]}
  scope :admin, ->{where role: GroupMember.roles[:admin]}
  scope :member, ->{where confirm: true}
  scope :request, ->{where confirm: false}
  scope :member_team_organization, ->(user_id, organization_id) do
    where group_type: GroupMember.group_types[:team],
      user_id: user_id,
      group_id: Team.team_in_organization(organization_id).pluck(:id)
    end
end
