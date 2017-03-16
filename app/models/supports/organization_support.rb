class Supports::OrganizationSupport
  attr_reader :organization

  def initialize organization
    @organization = organization
  end

  def members
    organization.group_members.organization_user.member
  end

  def requests
    organization.group_members.organization_user.request
  end

  def build_member
    organization.group_members.build
  end

  def member user
    GroupMember.find_by user_id: user.id, group_id: organization.id,
      group_type: GroupMember.group_types[:organization]
  end

  def document
    Document.new
  end

  def documents
    ids = Share.select(:document_id).share_organization.where(share_id: organization.id)
    Document.where(id: ids).order(created_at: :desc)
  end

  def teams
    Team.where(organization_id: organization.id)
  end

  def guide
    Document.find_by id: organization.guide_id
  end

  def read_guide user
    ReadGuide.find_by Organization_id: organization.id, User_id: user.id,
      read: ReadGuide.reads[:not_yet]
  end
end
