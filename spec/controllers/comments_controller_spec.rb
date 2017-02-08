require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  
  before :each do
    user = FactoryGirl.create :user
    sign_in(:user, user)
    @document = FactoryGirl.create :document
  end

  describe "POST #create" do
    it "expect comment successful save" do
      Comment.any_instance.stub(:valid?).and_return(true)
      post :create, params: {document_id: @document.id, comment: {content: "abc"}}
      expect(assigns[:comment]).to be_an_instance_of Comment
    end

    it "comment empty" do
      Comment.any_instance.stub(:valid?).and_return(true)
      post :create, params: {document_id: @document.id, comment: {content: ""}}
      expect(assigns[:comment]).to be_an_instance_of Comment
    end
  end

end
