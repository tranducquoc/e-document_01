class Document < ApplicationRecord
  belongs_to :user, class_name: User.name
  belongs_to :category, class_name: Category.name
  has_many :comments, class_name: Comment.name
  has_many :reads, class_name: Read.name
  has_many :favorites, class_name: Favorite.name
  has_many :downloads, class_name: Download.name

  validates :name, presence: true, length: {maximum: Settings.content_size_max}
end
