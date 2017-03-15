class Api::TeamMembersController < ApplicationController
  def index
    team = Team.find_by id: params[:team_id]
    ids = GroupMember.team_user.member.select(:user_id).where(group_id: team.id)
    users = params[:user_name].present? ? User.search(params[:user_name]).
      where(id: ids) : User.where(id: ids)
    @members = team.group_members.team_user.member.where(user_id: users.ids)
    respond_to do |format|
      format.html do
        render partial: "teams/members",
          locals: {members: @members, team: team}
      end
    end
  end
end
