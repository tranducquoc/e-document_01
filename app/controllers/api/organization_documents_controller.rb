class Api::OrganizationDocumentsController < ApplicationController
  def index
    @organization = Organization.find_by id: params[:id]
    ids = @organization.document_ids
    @documents = if params[:name].present?
      Document.search(params[:name]).where(id: ids)
    else
      Document.where(id: ids)
    end
    respond_to do |format|
      format.html do
        render partial: "organizations/show_tpl/documents",
          locals: {documents: @documents, organization: @organization}
      end
    end
  end
end
