class Api::DocumentsController < ApplicationController
  def index
    if params[:category_id].blank?
      @documents = Document.all
    else
      category = Category.find_by id: params[:category_id]
      @documents = Document.where(category_id: category.id)
    end
    respond_to do |format|
      format.html do
        render partial: "admin/documents/documents",
        locals: {documents: @documents}
      end
    end
  end
end
