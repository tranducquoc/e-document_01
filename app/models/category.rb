class Category < ApplicationRecord
  has_many :documents, class_name: Document.name, foreign_key: :document_id

  validate :name, presence: true, length: {maximum: Settings.name_size_max}
end
