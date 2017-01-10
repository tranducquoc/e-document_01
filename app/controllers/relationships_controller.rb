class RelationshipsController < ApplicationController
  before_action :verify_user

  def create
    @user = User.find_by id: params[:user_two_id]
    redirect_to root_path if @user.nil?
    current_user.add_friend @user
    redirect_to users_path
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).user_two
    redirect_to root_path if @user.nil?
    if @user == current_user
      @user = Relationship.find_by(id: params[:id]).user_one
      @user.un_friend current_user
    else
      current_user.un_friend @user
    end
    redirect_to users_path
  end
end
