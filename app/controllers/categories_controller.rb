class CategoriesController < ApplicationController
  def show
    @documents = @category.document.page(params[:page])
      .per Settings.document.per_page
  end

  def index
    @q = Category.search params[:q]
    @categories = @q.result(distinct: true).order("created_at DESC")
      .page(params[:page]).per Settings.categories.per_page
  end
end
