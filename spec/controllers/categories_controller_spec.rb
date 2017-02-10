require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  let!(:category) {FactoryGirl.create :category}
  let!(:document) {FactoryGirl.create :document}

  describe "GET #show/:id" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, params:{id: category.id}
      expect(response).to have_http_status(200)
    end

    it "category not found" do
      get :show, params:{id: 9999}
      expect(flash[:warning]).to be_present
    end
  end
end
