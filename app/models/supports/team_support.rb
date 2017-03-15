class Supports::TeamSupport
  attr_reader :team

  def initialize team
    @team = team
  end

  def members
    team.group_members.team_user.member
  end

  def requests
    team.group_members.team_user.request
  end

  def build_member
    team.group_members.build
  end

  def find_member user
    GroupMember.find_by user_id: user.id, group_id: team.id,
      group_type: GroupMember.group_types[:team]
  end

  def add_member organization
    organization_ids = GroupMember.organization_user.member.select(:user_id)
      .where(group_id: organization.id)
    team_ids = GroupMember.team_user.select(:user_id).where(group_id: team.id)
    User.where(id: organization_ids).where.not(id: team_ids)
  end

  def documents organization, int
    ids = Share.select(:document_id).share_organization.where(share_id: organization.id)
    Document.where(id: ids).order(created_at: :desc).page(int)
      .per Settings.organs_per_page
  end
end
