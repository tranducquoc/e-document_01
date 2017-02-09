require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before :each do
    @user = User.first
    category = FactoryGirl.create :category
    sign_in(:user, @user)
    @coin = FactoryGirl.create :coin
  end

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      document = FactoryGirl.create :document
      get :show, params:{id: @user.slug}
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "responds successfully with an HTTP 200 status code - index variable" do
      get :index, params: {page: 1}
      expect(assigns[:index]).to eq(0)
    end
  end

  describe "PUT #update" do
    it "update coin fail error" do
      put :update, params: {id: @user.slug, code: "code-100000"}
      expect(assigns[:coin]).to be_nil
    end

    it "update coin fail error-nil" do
      put :update, params: {id: @user.slug, code: ""}
      expect(assigns[:coin]).to be_nil
    end

    it "update coin fail error-used" do
      @coin.status = "used"
      @coin.save!
      put :update, params: {id: @user.slug, code: @coin.code}
      expect(flash[:warning]).to be_present
      expect(response).to redirect_to(new_buycoin_path)
    end

    it "update coin successfully" do
      @coin.status = "checked"
      @coin.save!
      put :update, params: {id: @user.slug, code: @coin.code}
      expect(flash[:success]).not_to be_blank
      expect(response).to redirect_to(new_buycoin_path)
    end

    it "update coin unsuccessfully-bought" do
      @coin.status = "bought"
      @coin.save!
      put :update, params: {id: @user.slug, code: @coin.code}
      expect(flash[:warning]).to be_present
      expect(response).to redirect_to(new_buycoin_path)
    end

    it "update coin unsuccessfully-available" do
      @coin.status = "available"
      @coin.save!
      put :update, params: {id: @user.slug, code: @coin.code}
      expect(flash[:warning]).to be_present
      expect(response).to redirect_to(new_buycoin_path)
    end
  end
end
