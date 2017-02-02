class Api::UsersController < ApplicationController
  def index
    @users = params[:user_name].present? ? User.all : User.search(params[:user_name])
    respond_to do |format|
      format.html do
        render partial: "admin/users/users",
        locals: {users: @users}
      end
    end
  end
end
