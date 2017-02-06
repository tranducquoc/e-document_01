require "rails_helper"

RSpec.describe Download, type: :model do
  describe "download count" do
    it "download count  equal 0" do
      expect(Download.download_count(Time.now)).to eq(0)
    end

    it "download count  equal 10" do
      expect(Download.download_count(Time.now)).not_to eq(10)
    end
  end

  describe "user download free count" do
    before :each do
      @user = User.last
    end
    it "user download count  equal 0" do
      expect(Download.get_download_free(@user,Time.now)).to eq(0)
    end

    it "user download count  equal 10" do
      expect(Download.get_download_free(@user,Time.now)).not_to eq(10)
    end
  end

  describe "associations" do
    it{expect belong_to(:user)}
    it{expect belong_to(:document)}
  end
end
