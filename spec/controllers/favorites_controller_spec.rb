require "rails_helper"

RSpec.describe FavoritesController, type: :controller do
  
  before :each do
    @user = FactoryGirl.create :user
    sign_in(:user, @user)
    @document = FactoryGirl.create :document
  end

  describe "POST #create" do
    it "expect comment successful save" do
      Favorite.any_instance.stub(:valid?).and_return(true)
      post :create, params: {document_id: @document.id}
      expect(assigns[:favorite]).to be_an_instance_of Favorite
    end
  end

  describe "DELETE #destroy" do
    it "delete a favorite successfully" do
      favorite = FactoryGirl.create :favorite
      favorite.user = @user
      favorite.document = @document
      favorite.save
      delete :destroy, params: {id: favorite.id}
      expect change(Favorite, :count).by(-1)
    end

    it "delete a favorite failure" do
      favorite = FactoryGirl.create :favorite
      favorite.user = @user
      favorite.document = @document
      favorite.save
      allow_any_instance_of(Favorite).to receive(:destroy).and_return(false)
      delete :destroy, params: {id: favorite.id}
      expect change(Favorite, :count).by(0)
    end
  end
end
