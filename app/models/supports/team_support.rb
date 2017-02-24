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
end
