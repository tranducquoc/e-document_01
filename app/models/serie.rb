class Serie < ApplicationRecord
  has_many :documents
  belongs_to :user
end
