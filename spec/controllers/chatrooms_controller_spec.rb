require "rails_helper"

RSpec.describe ChatroomsController, type: :controller do
  before :each do
    user = FactoryGirl.create :user
    sign_in(:user, user)
  end
  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      chatroom = FactoryGirl.create :chatroom
      get :show, params: {id: chatroom.id}
      expect(response).to have_http_status(200)
    end

    it "redirect to root_path" do
      chatroom = FactoryGirl.create :chatroom
      user_guest = User.first
      user_host = User.second
      chatroom.guest = user_guest
      chatroom.host = user_host
      chatroom.save
      get :show, params: {id: chatroom.id}
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #new" do
    it "assigns a blank chatroom to the view" do
      User.any_instance.stub(:valid?).and_return(true)
      get :new, params: {guest_id: User.first.id}
      expect(assigns[:guest]).not_to be_new_record
    end
  end

  describe "POST #create" do
    it "expect chatroom successful save" do
      Chatroom.any_instance.stub(:valid?).and_return(true)
      post :create, params: {chatroom:{title: "Hello", guest_id: User.first.id}}
      expect(assigns[:chatroom]).to be_an_instance_of Chatroom
    end

    it "should re-render new template on failed save" do
      Chatroom.any_instance.stub(:valid?).and_return(false)
      post :create, params: {chatroom:{title: "Hello", guest_id: User.first.id}}
      expect(assigns[:chatroom]).to be_new_record
      expect(response).to render_template(:new)
    end
  end
end
