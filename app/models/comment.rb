class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :document
  validates :content, presence: true
  class << self
    def newest
      Comment.order(created_at: :desc)
    end
  end
end
