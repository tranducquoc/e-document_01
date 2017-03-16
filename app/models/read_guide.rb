class ReadGuide < ApplicationRecord
  belongs_to :organization
  belongs_to :user

  enum reads: [:not_yet, :done]
end
