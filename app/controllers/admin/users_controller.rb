class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :load_user, only: [:update, :destroy]

  def index
    if params[:search].present?
      @users = User.search(params[:search]).order(updated_at: :desc).page(params[:page])
        .per Settings.users.per_page
    else
      @users = User.all.order(updated_at: :desc).page(params[:page])
        .per Settings.users.per_page
    end
  end

  def update
    params[:role] = :admin
    if @user.update_attributes user_params
      flash[:success] = t "update_success"
    else
      flash[:danger] = t "update_error"
    end
    redirect_to admin_users_path
  end

  def destroy
    if @user && @user.destroy
      flash[:success] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_error"
    end
    redirect_to admin_users_path
  end

  private
  def user_params
    params.permit :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash.now[:warning] = t "user.not_found"
      render_404
    end
  end
end
