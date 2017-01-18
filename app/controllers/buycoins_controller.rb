class BuycoinsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_buycoin, only: :update

  def new
    @buycoin = Buycoin.new
  end

  def create
    @buycoin = current_user.buycoins.build
    @coin = Coin.get_coin params[:value_coin].to_i
    @buycoin.coin = @coin
    if @buycoin.save
      @coin.update_attributes status: :bought
      flash[:success] = t ".create_success"
    else
      render :new
    end
    redirect_to root_path
  end

  private
  def load_buycoin
    @buycoin = Buycoin.find_by id: params[:id]
    unless @buycoin
      flash.now[:warning] = t "buycoin.not_found"
      render_404
    end
  end
end
