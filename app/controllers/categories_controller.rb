class CategoriesController < ApplicationController
  def index
    @q = Category.search params[:q]
    @categories = @q.result(distinct: true).order("created_at DESC")
      .page(params[:page]).per Settings.categories.per_page
  end
end
