require "rails_helper"

RSpec.describe Document, type: :model do
  describe "document db schema" do
    context "columns" do
      it {should have_db_column(:name).of_type(:string)}
      it {should have_db_column(:description).of_type(:string)}
      it {should have_db_column(:attachment).of_type(:string)}
      it {should have_db_column(:status).of_type(:integer)}
      it {should have_db_column(:category_id).of_type(:integer)}
      it {should have_db_column(:user_id).of_type(:integer)}
      it {should have_db_column(:view).of_type(:integer)}
    end
  end

  describe "test model document" do
    subject{FactoryGirl.create :document}
    it{is_expected.to be_valid}

    context "associations" do
      it {is_expected.to belong_to :user}
      it {is_expected.to belong_to :category}
      it {is_expected.to have_many :comments}
      it {is_expected.to have_many :favorites}
      it {is_expected.to have_many :reads}
      it {is_expected.to have_many :favorites}
      it {is_expected.to have_many :downloads}
    end

    context "validations" do
      it {should validate_presence_of(:name)}
      it{expect validate_length_of(:name).is_at_most(45)}
    end
  end

  describe "upload count" do
    it "upload count  equal 0" do
      expect(Document.upload_count(Time.now)).to eq(0)
    end
    it "upload count not equal 10" do
      expect(Document.upload_count(Time.now)).not_to eq(10)
    end
  end

  describe "document in category" do
    subject{Document.first}
    it "the first document in category 3" do
      expect(Document.in_category(subject.category.id)).to include(subject)
    end

    it "the first document not in category 3" do
      expect(Document.in_category(3)).not_to include(subject)
    end
  end

  describe "own documents" do
    subject{FactoryGirl.create :user}
    before :each do
      @document = Document.first
    end 
    it "New user hasn't document 3" do
      expect(Document.own_documents(subject)).not_to include(@document)
    end
    it "New user 2 has 0 document" do
      expect(Document.own_documents(subject).count).to eq(0)
    end
  end

  describe "newest documents" do
    subject{Document.newest}
    before :each do
      @document = Document.last
    end 
    it "newest document to equal last document" do
      expect(subject.first).not_to eq(@document)
    end
  end

  describe "read documents" do
    read = FactoryGirl.create :read
    user = read.user
    subject{Document.get_read_document(user)}
    it "read document exists" do
      expect(subject.count).to be > 0
    end
  end

end
