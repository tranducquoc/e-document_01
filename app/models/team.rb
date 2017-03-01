class Team < ApplicationRecord
  belongs_to :organization
  has_many :group_members, foreign_key: :group_id ,dependent: :destroy

  accepts_nested_attributes_for :group_members

  enum group_type: [:organization, :team]
  enum role: [:member, :admin]

  validates :name, presence: :true, uniqueness: true

  def create_team_owner user
    GroupMember.create!(
      user_id: user.id,
      group_id: self.id,
      group_type: GroupMember.group_types[:team],
      role: GroupMember.roles[:admin],
      confirm: true
    )
  end

  def create_team_request user
    GroupMember.create!(
      user_id: user.id,
      group_id: self.id,
      group_type: GroupMember.group_types[:team],
      role: GroupMember.roles[:member],
      confirm: false
    )
  end

  def add_member user
    GroupMember.create!(
      user_id: user.id,
      group_id: self.id,
      group_type: GroupMember.group_types[:team],
      role: GroupMember.roles[:member],
      confirm: true
    )
  end

  def has_member? user
    GroupMember.team_user.member.find_by user_id: user.id, group_id: self.id
  end

  def has_admin? user
    GroupMember.team_user.admin.find_by user_id: user.id, group_id: self.id
  end
end
