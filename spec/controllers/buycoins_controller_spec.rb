require "rails_helper"

RSpec.describe BuycoinsController, type: :controller do
  
  before :each do
    user = FactoryGirl.create :user
    sign_in(:user, user)
  end

  describe "GET #new" do
    it "assigns a blank buycoin to the view" do
      get :new
      expect(assigns(:buycoin)).to be_a_new(Buycoin)
    end
  end

  describe "POST #create" do
    it "expect redirect to index with a notice on successful save" do
      Buycoin.any_instance.stub(:valid?).and_return(true)
      post :create, params: {value_coin: 20}
      expect(assigns[:buycoin]).not_to be_new_record
      expect(flash[:success]).not_to be_blank
      expect(response).to redirect_to(root_path)
    end

    it "should re-render new template on failed save" do
      Buycoin.any_instance.stub(:valid?).and_return(false)
      post :create, params: {value_coin: 0}
      expect(assigns[:buycoin]).to be_new_record
      expect(response).to render_template(:new)
    end

    it "should pass params to buycoin" do
      post :create, params: {value_coin: 20}
      expect(assigns[:buycoin].coin.value).to eq(20)
    end
  end

end
