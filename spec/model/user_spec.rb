require "rails_helper"

RSpec.describe User, type: :model do
  it ".email_admin" do
    user = FactoryGirl.create :user, role: :admin
    User.email_admin.should include(user)
  end

  describe "User db schema" do
    context "column" do
      it{expect have_db_column(:name).of_type(:string)}
      it{expect have_db_column(:email).of_type(:string)}
      it{expect have_db_column(:address).of_type(:string)}
      it{expect have_db_column(:phone_number).of_type(:string)}
      it{expect have_db_column(:role).of_type(:integer)}
      it{expect have_db_column(:point).of_type(:integer)}
      it{expect have_db_column(:slug).of_type(:string)}
      it{expect have_db_column(:provider).of_type(:string)}
      it{expect have_db_column(:uid).of_type(:string)}
    end
  end

  describe "validating" do
    subject{FactoryGirl.create :user}
    context "associations" do
      it{is_expected.to have_many :documents}
      it{is_expected.to have_many :downloads}
      it{is_expected.to have_many :favorites}
      it{is_expected.to have_many :reads}
      it{is_expected.to have_many :comments}
      it{is_expected.to have_many :active_relationships}
      it{is_expected.to have_many :passive_relationships}
      it{is_expected.to have_many :followings}
      it{is_expected.to have_many :followers}
      it{is_expected.to have_many :active_conversations}
      it{is_expected.to have_many :passive_relationships}
      it{is_expected.to have_many :messages}
      it{is_expected.to have_many :buycoins}
    end

    context "validates" do
      it{expect validate_presence_of :name}
      it{expect validate_presence_of :email}
    end
  end

  it "role user" do
    user = FactoryGirl.create :user
    expect(user.role).to eql "member"
  end

  auth_hash = OmniAuth::AuthHash.new({
    provider: "facebook",
    uid: "1991",
    info: {
      name: "kominam",
      email: "tuanh@gmail.com"
    }
  })

  describe "social login" do
    it ".from_omniauth" do
      user = FactoryGirl.create(:user,
        provider: "facebook",
        uid: "1991",
        email: "tuanh@gmail.com",
        password: "password",
        password_confirmation: "password"
      )
      user.save
      omniauth_user = User.from_omniauth(auth_hash)
      expect(user).to eq(omniauth_user)
    end

    it "create new user if exist" do
      expect{User.from_omniauth(auth_hash)}.to change(User, :count).by 1
    end
  end

  describe "user relationship" do
    before :each do
      @other = User.last
    end
    subject {User.first}
    it ".addfriend" do
      subject.add_friend(@other).should be_a(Relationship)
    end

    it ".un_friend" do
      expect(subject.un_friend(@other)).to be_truthy
    end

    it ".friend_list" do
      expect(subject.friendlist?(@other)).to be true
    end
  end

  describe "Search user" do
    subject{User.search("hoat")}
    before :each do
      @user = User.first
    end
    it ".search" do
      expect(subject).to include(@user)
    end

    it ".count_user" do
      expect(subject.count).to eq(2)
    end
  end

  describe "send_email" do
    subject{User.send_mail_if_not_login}
    before :each do
      @user = FactoryGirl.create :user
    end
    it ".find user" do
      expect(subject).to include(@user)
    end
  end
end
