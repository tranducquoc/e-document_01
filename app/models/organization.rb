class Organization < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :group_members, foreign_key: :group_id, dependent: :destroy

  accepts_nested_attributes_for :group_members

  validates :name, presence: true, length: {maximum: Settings.organization.name.max_length}

  def create_organization_owner user
    GroupMember.create!(user_id: user.id,
      group_id: self.id,
      group_type: GroupMember.group_types[:organization],
      role: GroupMember.roles[:admin],
      confirm: true)
  end

  def join_organization user
    GroupMember.create!(user_id: user.id,
      group_id: self.id,
      group_type: GroupMember.group_types[:organization],
      role: GroupMember.roles[:member],
      confirm: false)
  end

  def has_member? user
    GroupMember.organization_user.member.find_by user_id: user.id, group_id: self.id
  end

  def is_admin? user
    GroupMember.organization_user.admin.find_by user_id: user.id, group_id: self.id
  end
end
