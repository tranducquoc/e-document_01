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
    organization_ids = GroupMember.organization_user.member.select(:id).where(group_id: organization.id)
    team_ids = GroupMember.team_user.select(:id).where(group_id: team.id)
    ids = organization_ids - team_ids
    User.where(id: ids)
  end
end
