require "rails_helper"

RSpec.describe Admin::BuycoinsController, type: :controller do
  before :each do
    @user = User.first
    sign_in(:user, @user)
    @buycoin = FactoryGirl.create :buycoin
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end

    it "expect new buycoin is the first buycoin of list" do
      get :index
      buycoin = FactoryGirl.create :buycoin
      expect(assigns[:buycoins].first).to eq(buycoin)
    end
  end

  describe "PUT update/:id" do
    it "buycoin not found" do
      put :update, params: {id: 999999}
      expect(assigns[:buycoin]).to be_nil
    end

    it "update buycoin successfully" do
      Buycoin.any_instance.stub(:valid?).and_return(true)
      put :update, params: {id: @buycoin.id}
      expect(flash[:success]).not_to be_blank
      expect(response).to redirect_to(admin_buycoins_path)
    end

    it "update buycoin failure" do
      Buycoin.any_instance.stub(:valid?).and_return(false)
      put :update, params: {id: @buycoin.id}
      expect(flash[:danger]).not_to be_blank
      expect(response).to redirect_to(admin_buycoins_path)
    end
  end

end
