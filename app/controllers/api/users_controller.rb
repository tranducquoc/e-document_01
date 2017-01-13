class Api::UsersController < ApplicationController
  def index
    @users = params[:search].present? ? User.all : User.search(params[:search])
    respond_to do |format|
      format.html do
        render partial: "admin/users/users",
        locals: {users: @users}
      end
    end
  end
end
