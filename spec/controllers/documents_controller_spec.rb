require "rails_helper"

RSpec.describe DocumentsController, type: :controller do
  let!(:user){FactoryGirl.create :user}
  before :each do
    sign_in(:user, user)
    @document = FactoryGirl.create :document
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to have_http_status(200)
    end

    it "expect new document_support to be_truthy" do
      get :index
      category = FactoryGirl.create :category
      expect(assigns[:categories].last).to eq(category)
      expect(assigns(:document_support)).to be_truthy
    end
  end

  describe "GET #new" do
    it "assigns a blank document to the view" do
      get :new
      expect(assigns(:document)).to be_a_new(Document)
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

  describe "GET show/:id" do
    it "document not found" do
      get :show, params: {id: 999999}
      expect(response).to have_http_status(404)
    end

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: {id: Document.first.id}
      expect(response).to have_http_status(200)
    end

    it "responds failure with an HTTP 404 status code where document is waiting" do
      get :show, params: {id: @document.id}
      expect(response).to have_http_status(404)
    end

    it "List comment of the first document to be nil" do
      get :show, params: {id: @document.id}
      expect(assigns[:comments]).to be_nil
    end

    it "List favorited document of current_user to be nil" do
      get :show, params: {id: @document.id}
      expect(assigns[:document_fav]).to be_nil
    end

    it "current user read document" do
      get :show, params: {id: @document.id}
      expect change(Read, :count).by(1)
    end
  end

  describe "POST #create" do
    it "expect redirect to root with a notice on successful save" do
      Document.any_instance.stub(:valid?).and_return(true)
      post :create, params: {document: {name: "Dummy", description: "no",
        attachment: "abc", category_id: Category.first.id}}
      expect(assigns[:document]).not_to be_new_record
      expect(flash[:success]).not_to be_blank
      expect(response).to redirect_to(root_path)
    end

    it "expect re-render new template on failed save" do
      Document.any_instance.stub(:valid?).and_return(false)
      post :create, params: {document: {name: "Dummy", description: "no",
        attachment: "abc", category_id: Category.first.id}}
      expect(response).to render_template(:new)
    end

    it "expect the new document has name is Dummy" do
      post :create, params: {document: {name: "Dummy", description: "no",
        attachment: "abc", category_id: Category.first.id}}
      expect(assigns[:document].name).to eq("Dummy")
    end
  end
end
