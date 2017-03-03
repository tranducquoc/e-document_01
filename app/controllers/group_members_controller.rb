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
    if @team.present?
      update_team_member
    elsif @organization.present?
      update_organization_member
    end
  end

  def destroy
    if @team.present?
      destroy_team_member
    elsif @organization.present?
      destroy_organization_member
    end
  end

  private

  def create_team_member
    if @team.has_admin? current_user
      user = User.find_by id: params[:user_id]
      @team.add_member user
      respond_to do |format|
        format.json do
          render json: {status: status}
        end
      end
    elsif
      @team.create_team_request current_user
      flash[:success] = t "team.admin.create"
      redirect_to :back
    end
  end

  def update_team_member
    case @group_member.confirm
    when true
      @group_member.role = GroupMember.roles[:admin]
      @group_member.save
    when false
      @group_member.confirm = true
      if @group_member.save
        flash[:success] = t "team.admin.add"
      else
        flash[:danger] = t "team.admin.add_fail"
      end
    end
    respond_to do |format|
      format.json do
        render json: {status: status}
      end
    end
  end

  def create_organization_member support
    if @organization.is_admin? current_user
      user = User.find_by id: params[:user_id]
      @organization.add_member user
      status = t "organizations.show.added_member"
      respond_to do |format|
        format.json do
          render json: {status: status}
        end
      end
    elsif @organization.join_organization current_user
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

  def update_organization_member
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

  def destroy_team_member
    if @group_member.destroy
      flash[:success] = t "team.admin.destroy"
      if @team.has_admin? current_user
        respond_to do |format|
          format.json do
            render json: {status: status}
          end
        end
      else
        redirect_to :back
      end
    end
  end

  def destroy_organization_member
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
end
