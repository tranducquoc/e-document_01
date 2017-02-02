class Admin::BuycoinsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!, :verify_admin
  before_action :load_buycoin, only: :update

  def index
    @buycoins = Buycoin.all.where(status: :waiting).order(updated_at: :desc)
      .page(params[:page]).per Settings.buycoins.per_page
  end

  def update
    params[:status] = :checked
    if @buycoin.update_attributes buycoin_params
      @buycoin.coin.update_attributes status: :checked
      code_coin = CodeCoin.new @buycoin
      Delayed::Job.enqueue code_coin, Settings.priority,
        Settings.time_delay.seconds.from_now
      flash[:success] = t "update_success"
    else
      flash[:danger] = t "update_error"
    end
    redirect_to admin_buycoins_path
  end

  private
  def buycoin_params
    params.permit :status
  end

  def load_buycoin
    @buycoin = Buycoin.find_by id: params[:id]
    unless @buycoin
      flash.now[:warning] = t "buycoin.not_found"
      render_404
    end
  end
end
