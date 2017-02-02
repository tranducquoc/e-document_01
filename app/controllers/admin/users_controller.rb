class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!, :verify_admin
  load_and_authorize_resource find_by: :slug

  def index
    @users = User.all.order(updated_at: :desc)
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
end
