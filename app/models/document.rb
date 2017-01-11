class Document < ApplicationRecord
  belongs_to :user, class_name: User.name
  belongs_to :category, class_name: Category.name
  has_many :comments, class_name: Comment.name
  has_many :reads, class_name: Read.name
  has_many :favorites, class_name: Favorite.name
  has_many :downloads, class_name: Download.name

  mount_uploader :attachment, AttachmentUploader
  validates :name, presence: true, length: {maximum: Settings.content_size_max}

  scope :in_category, -> category_id do
    where category_id: category_id if category_id.present?
  end
end
