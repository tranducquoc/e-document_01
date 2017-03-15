class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource

  def index
    @organizations = Organization.all.page(params[:page])
      .per Settings.organs_per_page
    @organization = Organization.new
  end

  def show
    @member = @organization.members.find_by user_id: current_user.id
    @support = Supports::OrganizationSupport.new @organization
    if params[:tab_id].present?
      show_tab @support
    end
  end

  def create
    @organization = Organization.new organization_params
    if @organization.save
      @organization.create_organization_owner current_user
      flash[:success] = t ".organization_was_added"
      redirect_to @organization
    else
      render :new
    end
  end

  def update
    if @organization.has_admin? current_user
      if params[:guide_id].present?
        @organization.update_attributes guide_id: params[:guide_id]
        flash[:success] = t ".organization_was_edited"
        redirect_to :back
      else
        if @organization.update_attributes organization_params
          flash[:success] = t ".organization_was_edited"
          redirect_to @organization
        else
          flash[:danger] = t ".can_not_edit"
          render :edit
        end
      end
    else
      flash[:danger] = t ".do_not_have_permission!"
      redirect_to @organization
    end
  end

  def destroy
    if @organization.has_admin? current_user
      if @organization.destroy
        flash[:success] = t ".organization_was_deleted"
        redirect_to organizations_path
      else
        flash[:danger] = t ".can_not_delete"
        redirect_to @organization
      end
    else
      flash[:danger] = t ".do_not_have_permission!"
      redirect_to @organization
    end
  end

  private

  def organization_params
    params.require(:organization).permit :name, :picture, :description,
      group_member_attributes: [:user_id, :group_id, :group_type, :role, :confirm]
  end

  def show_tab support
    case params[:tab_id]
    when "members"
      members = support.members
    when "requests"
      members = support.requests
    end
    respond_to do |format|
      format.html do
        render partial: "organizations/show_tpl/members",
          locals: {group_members: members}
      end
    end
  end

end
