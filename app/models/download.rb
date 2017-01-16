class Download < ApplicationRecord
  belongs_to :user, class_name: User.name
  belongs_to :document, class_name: Document.name

  scope :download_count, ->date_time do
    where("date(created_at) = '#{date_time}'").count
  end
end
