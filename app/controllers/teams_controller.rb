class TeamsController < ApplicationController
  before_action :authenticate_user!
  load_resource :organization
  load_and_authorize_resource through: :organization

  def create
    @team = @organization.teams.build team_params
    if @team.save
      @team.create_team_owner current_user
      flash[:success] = t "team.create.success"
      redirect_to [@team.organization, @team]
    else
      render :new
    end
  end

  def update
    if @team.update_attributes team_params
      flash[:success] = t "team.edit.success"
      redirect_to [@team.organization, @team]
    else
      render :edit
    end
  end

  def destroy
    if @team.destroy
      flash[:success] = t "team.delete.success"
      redirect_to organization_teams_url
    else
      redirect_to :back
    end
  end

  private
  def team_params
    params.required(:team).permit :name,
      team_members_attributes[:user_id, :group_id, :group_type, :role]
  end
end
