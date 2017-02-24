class Organization < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :group_members, foreign_key: :group_id, dependent: :destroy

  accepts_nested_attributes_for :group_members

  validates :name, presence: true, length: {maximum: Settings.organization.name.max_length}

  enum group_type: [:organization, :team]
  enum role: [:member, :admin]

  def create_organization_owner user
    GroupMember.create!(user_id: user.id,
      group_id: self.id,
      group_type: Organization.group_types[:organization],
      role: Organization.roles[:admin],
      confirm: true)
  end

  def has_member? user
    GroupMember.organization_user.member.find_by user_id: user.id, group_id: self.id
  end

  def is_admin? user
    GroupMember.organization_user.admin.find_by user_id: user.id, group_id: self.id
  end
end
