class CategoriesController < ApplicationController
  before_action :load_category, only: [:update, :destroy, :show]

  def show
    @documents = @category.documents.where(status: :checked).page(params[:page])
      .per Settings.doc_per_page_1
  end

  private
  def load_category
    @category = Category.find_by id: params[:id]
    unless @category
      flash.now[:warning] = t "category.not_found"
      render_404
    end
  end
end
