class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource

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
    if @organization.is_admin? current_user && @organization.update_attributes(organization_params)
      flash[:success] = t ".organization_was_edited"
      redirect_to @organization
    else
      flash[:danger] = t ".can_not_edit!"
      redirect_to @organization
    end
  end

  def destroy
    if @organization.is_admin? current_user && @organization.destroy
      flash[:success] = t ".organization_was_deleted"
      redirect_to organizations_path
    else
      flash[:danger] = t ".can_not_delete"
      redirect_to @organization
    end
  end

  private

  def organization_params
    params.require(:organization).permit :name,
      group_member_attributes: [:user_id, :group_id, :group_type, :role, :confirm]
  end
end
