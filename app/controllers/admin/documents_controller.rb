class Admin::DocumentsController < ApplicationController
  load_and_authorize_resource
  layout "admin"
  before_action :load_document, only: [:update, :destroy]

  def index
    @documents = Document.all.order(updated_at: :desc).page params[:page]
    @categories = Category.all
  end

  def update
    params[:status] = :Checked
    if @document.update_attributes document_params
      flash[:success] = t ".update_success"
      @user = @document.user
      @user.update_attributes point: @user.point + Settings.coin_down
    else
      flash[:danger] = t ".update_error"
    end
    redirect_to admin_documents_path
  end

  def destroy
    if @document && @document.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_error"
    end
    redirect_to admin_documents_path
  end

  private
  def document_params
    params.permit :status
  end

  def load_document
    @document = Document.find_by id: params[:id]
    unless @document
      flash.now[:warning] = t "document.not_found"
      render_404
    end
  end
end
