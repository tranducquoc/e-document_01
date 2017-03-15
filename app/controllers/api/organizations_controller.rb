class Api::OrganizationsController < ApplicationController
  def index
    @organizations = params[:org_name].present? ?
      Organization.search(params[:org_name]) : Organization.all
    respond_to do |format|
      format.html do
        render partial: "organizations/organizations",
        locals: {organizations: @organizations}
      end
    end
  end
end
