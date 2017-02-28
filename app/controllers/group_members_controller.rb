class GroupMembersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  load_resource :organization
  load_resource :team

  def create
    if @team.present?
      create_team_member
    elsif @organization.present?
      support = Supports::OrganizationSupport.new @organization
      create_organization_member support
    end
  end

  def update
    @group_member.confirm = true
    if @group_member.save
      flash[:success] = t "team.admin.add"
      status = t "organizations.update.confirm"
    else
      flash[:danger] = t "team.admin.add_fail"
      status = t "organizations.update.cannot_confirm"
    end
    respond_to do |format|
      format.json do
        render json: {status: status}
      end
    end
  end

  def destroy
    if @group_member.destroy
      flash[:success] = t "team.admin.destroy"
      support = Supports::OrganizationSupport.new @organization
      respond_to do |format|
        format.html do
          render partial: "organizations/join",
            locals: {
              organization: @organization,
              support: support}
        end
      end
    else
      flash[:danger] = t "organizations.destroy.can_not_delete"
      redirect_to :back
    end
  end

  private

  def create_team_member
    if @team.create_team_request current_user
      flash[:success] = t "team.admin.create"
      redirect_to [@team.organization, @team]
    else
      redirect_to :back
    end
  end

  def create_organization_member support
    if @organization.join_organization current_user
      member = @organization.group_members.find_by user_id: current_user.id
      flash[:success] = t "organizations.create.sent_request"
      respond_to do |format|
        format.html do
          render partial: "organizations/leave",
          locals: {organization: @organization,
            member: member,
            support: support}
        end
      end
    else
      redirect_to @organization
    end
  end
end
