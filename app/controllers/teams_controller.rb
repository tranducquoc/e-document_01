class TeamsController < ApplicationController
  before_action :authenticate_user!
  load_resource :organization
  load_and_authorize_resource through: :organization

  def show
    @member = @team.members.find_by user_id: current_user.id
    @support = Supports::TeamSupport.new @team
  end

  def create
    if @organization.has_admin? current_user
      @team = @organization.teams.build team_params
      if @team.save
        @team.create_team_owner current_user
        flash[:success] = t "team.create.success"
        redirect_to [@team.organization, @team]
      else
        render :new
      end
    else
      redirect_to root_url
    end
  end

  def update
    if @team.has_admin?(current_user) && @team.update_attributes(team_params)
      flash[:success] = t "team.edit.success"
      redirect_to [@team.organization, @team]
    else
      render :edit
    end
  end

  def destroy
    if @team.has_admin?(current_user) && @team.destroy
      flash[:success] = t "team.delete.success"
      redirect_to organization_teams_url
    else
      redirect_to :back
    end
  end

  private
  def team_params
    params.required(:team).permit :name
  end
end
