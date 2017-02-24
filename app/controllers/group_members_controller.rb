class GroupMembersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  load_resource :team

  def create
    if @team.create_team_request current_user
      flash[:success] = t "team.admin.create"
      redirect_to [@team.organization, @team]
    else
      redirect_to :back
    end
  end

  def update
    @group_member.confirm = true
    if @group_member.save
      flash[:success] = t "team.admin.add"
    else
      flash[:danger] = t "team.admin.add_fail"
    end
    redirect_to :back
  end

  def destroy
    if @group_member.destroy
      flash[:success] = t "team.admin.destroy"
    end
    redirect_to :back
  end
end
