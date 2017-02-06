class DocumentsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  load_and_authorize_resource except: [:create, :update]
  before_action :load_document, only: [:update, :show]

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
      upload_document = UploadDocument.new @document, current_user
      Delayed::Job.enqueue upload_document, Settings.priority,
        Settings.time_delay.seconds.from_now
      flash[:success] = t ".create_success"
    else
      render :new
    end
    redirect_to root_path
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
    current_date = Time.now - Settings.number_seven_2
    @comments = @document.comments.newest
    if user_signed_in?
      @download_free = Download.get_download_free current_user,
        current_date.strftime(Settings.format_date)
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
    if @document.nil? || @document.waiting?
      flash.now[:warning] = t "document.not_found"
      render_404
    end
  end
end
