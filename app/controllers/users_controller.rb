class UsersController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource find_by: :slug

  def index
    @q = User.ransack params[:q]
    @users = @q.result(distinct: true).order("created_at DESC")
      .page(params[:page]).per Settings.users.per_page
  end

  def show
    @documents = @user.documents.order(created_at: :desc).page params[:page]
    @activities = PublicActivity::Activity.all.where(owner_id: @user.id)
      .order(created_at: :desc).page(params[:page]).per Settings.users.per_page
  end

  def update
    @coin = Coin.get_coin_by_code params[:code]
    if @coin.nil?
      flash[:warning] = t "coin_not_found"
    else
      case @coin.status
      when "used"
        flash[:warning] = t "coin_used"
      when "checked"
        current_user.update_attributes point: current_user.point + @coin.value
        @coin.update_attributes status: :used, user_id: current_user.id
        flash[:success] = t "coin_use_success"
      else
        flash[:warning] = t "coin_unavailable"
      end
    end
    redirect_to new_buycoin_path
  end
end
