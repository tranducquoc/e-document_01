class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).order("created_at DESC")
      .page(params[:page]).per Settings.users.per_page
  end
end
