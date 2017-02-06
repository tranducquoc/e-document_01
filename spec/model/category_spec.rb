require "rails_helper"

RSpec.describe Category, type: :model do

  describe "Category db schema" do
    context "column" do
      it{expect have_db_column(:name).of_type(:string)}
    end
  end

  describe "validating" do
    subject{FactoryGirl.create :category}
    context "association" do
      it{is_expected.to have_many :documents}
    end

    context "validates" do
      it{expect validate_presence_of :name}
      it{expect validate_length_of(:name).is_at_most(45)}
    end
  end

end
