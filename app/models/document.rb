class Document < ApplicationRecord
  acts_as_paranoid
  paginates_per Settings.users.per_page

  belongs_to :user, class_name: User.name
  belongs_to :category, class_name: Category.name

  has_many :comments, class_name: Comment.name
  has_many :reads
  has_many :favorites
  has_many :downloads

  mount_uploader :attachment, AttachmentUploader

  validates :name, presence: true, length: {maximum: Settings.document_length}

  enum status: [:waiting, :checked, :cancelled]

  paginates_per Settings.document_per_page

  scope :in_category, ->category_id do
    where category_id: category_id if category_id.present?
  end

  scope :upload_count, ->date_time do
    where("date(created_at) = '#{date_time}'").count
  end

  class << self
    def own_documents user
      user.documents.where(status: :checked).order(created_at: :desc)
        .limit(Settings.document.limit)
    end

    def newest
      Document.where(status: :checked).order(created_at: :desc)
        .limit(Settings.document.limit_1)
    end

    def get_read_document user
      document_ids = user.reads.order(created_at: :desc)
        .pluck("DISTINCT document_id")
      Document.where(id: document_ids).limit(Settings.document.limit_1)
    end
  end
end
