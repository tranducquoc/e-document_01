require "rails_helper"

RSpec.describe Chatroom, type: :model do
  describe "chatroom scope" do
    it "scope created room failure" do
      host = FactoryGirl.create :user
      guest = FactoryGirl.create :user
      created_room = Chatroom.created_room host, guest
      expect(created_room).not_to exist
    end
  end

  describe "validating" do
    context "association" do
      it{is_expected.to have_many(:messages).dependent(:destroy)}
    end
  end
end
