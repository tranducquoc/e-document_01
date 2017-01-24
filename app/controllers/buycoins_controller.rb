class BuycoinsController < ApplicationController
  before_action :authenticate_user!

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
end
