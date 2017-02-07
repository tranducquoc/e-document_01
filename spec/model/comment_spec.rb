require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "Comment db schema" do
    context "column" do
      it{expect have_db_column(:content).of_type(:string)}
    end
  end

  describe "validating" do
    context "association" do
      it{is_expected.to belong_to :user}
      it{is_expected.to belong_to :document}
    end

    context "validates" do
      it{expect validate_presence_of :content}
    end
  end

  describe "Newest Comment" do
    subject{Comment.newest}
    before :each do
      @comment = Comment.last
    end
    it "newest comment to equal last comment" do
      expect(subject.first).to eq(@comment)
    end

    it "newest comment not exist" do
      expect(subject).not_to exist
    end
  end
end
