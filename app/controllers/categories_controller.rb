class CategoriesController < ApplicationController
  load_and_authorize_resource

  def show
    @documents = @category.documents.checked.page(params[:page])
      .per Settings.doc_per_page_1
  end
end
