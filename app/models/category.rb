class Category < ApplicationRecord
  has_many :documents

  validates :name, presence: true, length: {maximum: Settings.name_size_max}
end
