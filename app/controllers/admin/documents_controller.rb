class Admin::DocumentsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!, :verify_admin
  load_and_authorize_resource

  def index
    @documents = Document.all.order(updated_at: :desc).page params[:page]
    @categories = Category.all
  end

  def update
    params[:status] = :checked
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
end
