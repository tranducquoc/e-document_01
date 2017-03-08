class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: :index
  load_and_authorize_resource
  load_resource :organization

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
    serie = Serie.create!(name: params[:series_name]) if params[:series_name].present?
    @document = current_user.documents.build document_params
    @document.serie_id = serie.id if serie.present?
    if @document.save
      if @organization.present?
        @organization.share_document @document
      end
      upload_document = UploadDocument.new @document, current_user
      Delayed::Job.enqueue upload_document, Settings.priority,
        Settings.time_delay.seconds.from_now
      flash[:success] = t ".create_success"
      @organization.present? ? (redirect_to :back) : (redirect_to root_url)
    else
      render :new
    end
  end

  def update
    if params[:document][:shares_attributes].nil?
      flash[:warning] = t ".user_shared_cannot_blank"
    else
      shares_attributes = []
      convert_to_hash shares_attributes, Share.share_types[:user]
      if @document.update_attributes document_params
        flash[:success] = t ".share_success"
      else
        flash[:warning] = t ".share_failure"
      end
    end
    redirect_to :back
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
      update_read @document
    end
  end

  private
  def document_params
    params.require(:document).permit :name, :description, :attachment,
      :category_id, :status_upload, :serie_id,
      shares_attributes: [:share_id, :share_type, :document_id]
  end

  def convert_to_hash shares_attributes, share_type
    params[:document][:shares_attributes].each do |user_id|
      shares_hash = Hash.new
      shares_hash[:share_id] = user_id
      shares_hash[:share_type] = share_type
      shares_attributes.push shares_hash
    end
    params[:document][:shares_attributes] = shares_attributes
  end

  def update_read document
    read = Read.find_by user_id: current_user.id, document_id: document.id
    if read.present?
      read.update_attributes read_count: read.read_count + 1
    else
      read = current_user.reads.build
      read.read_count = 1
      read.document = document
      read.save!
    end
  end
end
