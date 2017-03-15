class Api::TeamsController < ApplicationController
  def index
    @organization = Organization.find_by id: params[:id]
    @teams = params[:team_name].present? ?
      Team.search(params[:team_name]).where(organization_id: params[:id]) :
      Team.where(organization_id: params[:id])
    respond_to do |format|
      format.html do
        render partial: "organizations/show_tpl/teams",
        locals: {organization: @organization, teams: @teams}
      end
    end
  end
end
