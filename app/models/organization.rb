class Organization < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :group_members, foreign_key: :group_id, dependent: :destroy
  has_many :read_guides, dependent: :destroy
  has_many :series, foreign_key: :organization_id, class_name: Serie.name

  accepts_nested_attributes_for :group_members
  mount_uploader :picture, OrganizationPictureUploader
  validates :name, presence: true, length: {maximum: Settings.organization.name.max_length}
  validate :picture_size
  def members
    GroupMember.where group_id: self.id, group_type: GroupMember.group_types[:organization]
  end


  def create_organization_owner user
    GroupMember.create!(user_id: user.id,
      group_id: self.id,
      group_type: GroupMember.group_types[:organization],
      role: GroupMember.roles[:admin],
      confirm: true)
  end

  def add_member user
    GroupMember.create!(
      user_id: user.id,
      group_id: self.id,
      group_type: GroupMember.group_types[:organization],
      role: GroupMember.roles[:member],
      confirm: true)
  end

  def share_document document
    Share.create!( share_id: self.id,
      share_type: Share.share_types[:organization],
      document_id: document.id
      )
  end

  def has_member? user
    GroupMember.organization_user.member.find_by user_id: user.id, group_id: self.id
  end

  def has_admin? user
    GroupMember.organization_user.admin.find_by user_id: user.id, group_id: self.id
  end

  def picture_size
    if picture.size > Settings.organization.picture.max_size.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

  def document_ids
      Share.select(:document_id).where(share_type: Share.share_types[:organization],
        share_id: self.id)
    end

  class << self
    def search params_search
      Organization.where("name LIKE ?", "%#{params_search}%")
    end
  end

end
