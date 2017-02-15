class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource

  before_action only: :show do
    validate_permission_for_read_document @document
    validate_permission_for_document_status @document
  end

  def index
    @categories = Category.all
    @document_support = Supports::DocumentSupport.new
  end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.build document_params
    @document.status_upload = params[:document][:status_upload].to_i
    if @document.save
      upload_document = UploadDocument.new @document, current_user
      Delayed::Job.enqueue upload_document, Settings.priority,
        Settings.time_delay.seconds.from_now
      flash[:success] = t ".create_success"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @user = @document.user
    if @document.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_error"
    end
    redirect_to user_path(@user)
  end

  def show
    @document_sp = Supports::DocumentSupport.new
    if current_user.present?
      @review = Review.find_by document_id: @document.id,
        user_id: current_user.id
      @review = current_user.reviews.build if @review.nil?
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
end
