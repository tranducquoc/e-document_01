class Team < ApplicationRecord
  belongs_to :organization
  has_many :group_members, foreign_key: :group_id ,dependent: :destroy

  accepts_nested_attributes_for :group_members

  enum group_type: [:organization, :team]
  enum role: [:member, :admin]
  enum confirm: [:true, :false]

  validates :name, presence: :true

  def create_team_owner user
    GroupMember.create!(
      user_id: user.id,
      group_id: self.id,
      group_type: Team.group_types[:team],
      role: Team.roles[:admin],
      confirm: Team.confirms[:true]
    )
  end
end
