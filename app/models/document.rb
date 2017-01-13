class Document < ApplicationRecord
  acts_as_paranoid
  paginates_per Settings.users.per_page
  belongs_to :user, class_name: User.name
  belongs_to :category, class_name: Category.name
  has_many :comments, class_name: Comment.name
  has_many :reads
  has_many :favorites
  has_many :downloads, class_name: Download.name

  mount_uploader :attachment, AttachmentUploader
  validates :name, presence: true, length: {maximum: Settings.content_size_max}

  enum status: [:Wating, :Checked, :Cancelled]
  paginates_per Settings.users.per_page

  scope :in_category, ->category_id do
    where category_id: category_id if category_id.present?
  end

  class << self
    def own_documents user
      user.documents.where(status: :Checked).order(created_at: :desc)
        .limit(Settings.document.limit)
    end

    def newest
      Document.where(status: :Checked).order(created_at: :desc)
        .limit(Settings.document.limit)
    end
  end
end
