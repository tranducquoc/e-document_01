class Admin::DocumentsController < ApplicationController
  layout "admin"

  def index
    @documents = Document.all
    @categories = Category.all
  end
end
