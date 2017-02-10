require "rails_helper"

RSpec.describe RelationshipsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  before :each do
    sign_in(:user, user)
  end
  describe "Create-relationship" do
    it "Addfriend success" do
      @user1 = FactoryGirl.create :user
      user.add_friend(@user1)
      post :create, params:{user_two_id: User.last.id}
      expect(response).to redirect_to(users_path)
    end
  end

  describe "Destroy-relationship" do
    it "delete a friend succesfully" do
      @user2 = FactoryGirl.create :user
      user.add_friend(@user2)
      delete :destroy, params: {id: Relationship.last.id}
      expect change(Relationship, :count).by(-1)
    end

    it "deleted by a friend succesfully" do
      @user3 = FactoryGirl.create :user
      @user3.add_friend(user)
      delete :destroy, params: {id: Relationship.last.id}
      expect change(Relationship, :count).by(-1)
    end
  end
end
