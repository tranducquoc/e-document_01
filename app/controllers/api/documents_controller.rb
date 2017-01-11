class Api::DocumentsController < ApplicationController
  def index
    if params[:category_id].blank?
      @documents = Document.all.page params[:page]
    else
      category = Category.find_by id: params[:category_id]
      @documents = Document.where(category_id: category.id).page params[:page]
    end
    respond_to do |format|
      format.html do
        render partial: "admin/documents/documents",
        locals: {documents: @documents}
      end
    end
  end
end
