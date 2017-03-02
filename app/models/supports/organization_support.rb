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
end
