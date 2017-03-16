class Api::TeamRequestsController < ApplicationController
  def index
    team = Team.find_by id: params[:team_id]
    ids = GroupMember.team_user.request.select(:user_id).where(group_id: team.id)
    users = params[:user_name].present? ? User.search(params[:user_name]).
      where(id: ids) : User.where(id: ids)
    @requests = team.group_members.team_user.request.where(user_id: users.ids)
    respond_to do |format|
      format.html do
        render partial: "teams/requests",
          locals: {requests: @requests, team: team}
      end
    end
  end
end
