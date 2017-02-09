require "rails_helper"

RSpec.describe StaticPagesController, type: :controller do
  describe "all static pages" do
    it "render #home page" do
      get :show, params:{page: "home"}
      expect(response).to render_template :home
    end

    it "render #help page" do
      get :show, params:{page: "help"}
      expect(response).to render_template :help
    end

    it "render #about page" do
      get :show, params:{page: "about"}
      expect(response).to render_template :about
    end

    it "render 404 not found page" do
      get :show,  params:{page: "other"}
      expect(response).to render_template file: "#{Rails.root}/public/404.html"
    end
  end
end
