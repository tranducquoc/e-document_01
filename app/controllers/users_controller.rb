class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_document, only: [:show, :destroy]

  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).order("created_at DESC")
      .page(params[:page]).per Settings.users.per_page
  end

  def show
    @documents = @user.documents.order(created_at: :desc).page params[:page]
  end

  private
  def load_document
    @user = User.find_by id: params[:id]
    unless @user
      flash.now[:warning] = t "user.not_found"
      render_404
    end
  end
end
