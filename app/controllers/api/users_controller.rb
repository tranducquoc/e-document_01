class Api::UsersController < ApplicationController
  def index
    @users = params[:user_name].present? ? User.search(params[:user_name]) : User.all
    respond_to do |format|
      format.html do
        render partial: "admin/users/users",
        locals: {users: @users}
      end
    end
  end
end
