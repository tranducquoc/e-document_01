require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  before :each do
    @user = User.first
    sign_in(:user, @user)
    @user_test = FactoryGirl.create :user
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end

    it "expect new user is the first user of list" do
      get :index
      user = FactoryGirl.create :user
      expect(assigns[:users].first).to eq(user)
    end
  end

  describe "PUT update/:id" do
    it "update user successfully" do
      User.any_instance.stub(:valid?).and_return(true)
      put :update, params: {id: @user_test.slug}
      expect(flash[:success]).not_to be_blank
      expect(response).to redirect_to(admin_users_path)
    end

    it "update user failure" do
      User.any_instance.stub(:valid?).and_return(false)
      put :update, params: {id: @user_test.slug}
      expect(flash[:danger]).not_to be_blank
      expect(response).to redirect_to(admin_users_path)
    end
  end

  describe "DELETE #destroy" do
    it "delete a user successfully" do
      delete :destroy, params: {id: @user_test.slug}
      expect(flash[:success]).not_to be_blank
      expect change(Document, :count).by(-1)
    end

    it "delete a user failure" do
      allow_any_instance_of(User).to receive(:destroy).and_return(false)
      delete :destroy, params: {id: @user_test.slug}
      expect(flash[:danger]).not_to be_blank
      expect change(Document, :count).by(0)
    end
  end
end
