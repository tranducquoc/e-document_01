class SeriesController < ApplicationController
  before_action :load_serie

  def show
    @documents = @serie.documents.checked.page(params[:page])
      .per Settings.doc_per_page_1
  end

  def update
    @serie.name = params[:name]
    if @serie.save!
      flash[:success] = t ".success"
    else
      flash[:warning] = t ".fail"
    end
    redirect_to :back
  end

  private

  def load_serie
    @serie = Serie.find_by id: params[:id]
  end
end
