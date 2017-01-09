class Comment < ApplicationRecord
  belongs_to :user, class_name: User.name
  belongs_to :document, class_name: Document.name
end
