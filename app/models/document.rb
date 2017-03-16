class Document < ApplicationRecord
  acts_as_paranoid
  paginates_per Settings.users.per_page

  belongs_to :user
  belongs_to :category
  belongs_to :serie

  has_many :comments, dependent: :destroy
  has_many :reads, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :downloads, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :shares, dependent: :destroy, inverse_of: :document

  accepts_nested_attributes_for :shares, allow_destroy: true,
    reject_if: proc{|attributes| attributes[:share_id].blank?}

  mount_uploader :attachment, AttachmentUploader

  validates :name, presence: true, length: {maximum: Settings.document_length}

  enum status: [:waiting, :checked, :cancelled]
  enum status_upload: [:global, :shared, :individual]


  paginates_per Settings.document_per_page

  scope :in_category, ->category_id do
    where category_id: category_id if category_id.present?
  end

  scope :upload_count, ->date_time do
    where("date(created_at) = '#{date_time}'").count
  end

  def rate_average
    reviews.average(:rating).to_f if reviews.any?
  end

  class << self
    def own_documents user
      user.documents.checked.order(created_at: :desc)
        .limit(Settings.document.limit)
    end

    def newest
      Document.checked.order(created_at: :desc)
        .limit(Settings.document.limit_1)
    end

    def get_read_document user
      document_ids = user.reads.pluck(:document_id)
      Document.where(id: document_ids).order(updated_at: :desc)
        .limit(Settings.document.limit_1)
    end

    def search params_search
      Document.where("name LIKE ?", "%#{params_search}%")
    end
  end
end
