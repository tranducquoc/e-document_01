class Comment < ApplicationRecord
  belongs_to :user, class_name: User.name
  belongs_to :document, class_name: Document.name
  class << self
    def newest
      Comment.order(created_at: :desc)
    end
  end
end
