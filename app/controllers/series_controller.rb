class SeriesController < ApplicationController
  def show
    @serie = Serie.find_by id: params[:id]
    @documents = @serie.documents.checked.page(params[:page])
      .per Settings.doc_per_page_1
  end
end
