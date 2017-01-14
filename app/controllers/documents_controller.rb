class DocumentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  load_and_authorize_resource except: [:update, :destroy]
  before_action :load_document, only: [:update, :destroy, :show]

  def index
    @categories = Category.all
    @document_support = Supports::DocumentSupport.new
  end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.build document_params
    if @document.save
      flash[:success] = t ".create_success"
      DocumentMailer.delay.upload_document(@document, current_user)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = @document.comments.newest
    if user_signed_in?
      @document_fav = Favorite.find_by document_id: @document.id,
        user_id: current_user.id
      @document.update_attributes view: @document.view + 1
      read = current_user.reads.build
      read.document = @document
      read.save
    end
  end

  private
  def document_params
    params.require(:document).permit :name, :description, :attachment,
      :category_id
  end

  def load_document
    @document = Document.find_by id: params[:id]
    unless @document
      flash.now[:warning] = t "document.not_found"
      render_404
    end
  end
end
