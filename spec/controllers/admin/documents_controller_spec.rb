require "rails_helper"

RSpec.describe Admin::DocumentsController, type: :controller do
  before :each do
    @user = User.first
    sign_in(:user, @user)
    @document = FactoryGirl.create :document
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end

    it "expect new document is the first document of list" do
      get :index
      document = FactoryGirl.create :document
      expect(assigns[:documents].first).to eq(document)
    end
  end

  describe "PUT update/:id" do
    it "document not found" do
      put :update, params: {id: 999999}
      expect(assigns[:document]).to be_nil
    end

    it "update document successfully" do
      Document.any_instance.stub(:valid?).and_return(true)
      put :update, params: {id: @document.id}
      expect(flash[:success]).not_to be_blank
      expect(response).to redirect_to(admin_documents_path)
    end

    it "update document failure" do
      Document.any_instance.stub(:valid?).and_return(false)
      put :update, params: {id: @document.id}
      expect(flash[:danger]).not_to be_blank
      expect(response).to redirect_to(admin_documents_path)
    end
  end

  describe "DELETE #destroy" do
    it "delete a document successfully" do
      delete :destroy, params: {id: @document.id}
      expect(flash[:success]).not_to be_blank
      expect change(Document, :count).by(-1)
    end

    it "delete a document failure" do
      allow_any_instance_of(Document).to receive(:destroy).and_return(false)
      delete :destroy, params: {id: @document.id}
      expect(flash[:danger]).not_to be_blank
      expect change(Document, :count).by(0)
    end
  end
end
