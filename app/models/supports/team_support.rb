class Supports::TeamSupport
  attr_reader :team

  def initialize
  end

  def members team
    team.group_members.team_user.member
  end

  def requests team
    team.group_members.team_user.request
  end

  def build_team_member team
    team.group_members.build
  end

  def find_team_member team
    GroupMember.team_user.find_by group_id: team.id
  end
end
