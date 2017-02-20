class OrganizationsController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource

  def index
  end

  def show
  end

  def new
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

  def edit
  end

  def update
    if @organization.update_attributes organization_params
      flash[:success] = t ".organization_was_edited"
      redirect_to @organization
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    flash[:success] = t ".organization_was_deleted"
    redirect_to organizations_path
  end

  private

  def organization_params
    params.require(:organization).permit :name,
      group_member_attributes: [:user_id, :group_id, :group_type, :role, :confirm]
  end
end
