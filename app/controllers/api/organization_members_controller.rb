class Api::OrganizationMembersController < ApplicationController
  def index
    members = Organization.find_members params[:group_id], params[:user_name],
      confirm_data(params[:confirm])
    @organization = Organization.find_by id: params[:group_id]
    respond_to do |format|
      format.html do
        render partial: "organizations/show_tpl/member",
          locals: {group_members: members, organization: @organization}
      end
    end
  end

  private

  def confirm_data confirm
    confirm == "true"
  end
end
