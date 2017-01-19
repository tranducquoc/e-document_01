class Download < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new {|controller, model| controller.current_user},
    recipient: :document
  belongs_to :user
  belongs_to :document

  scope :download_count, ->date_time do
    where("date(created_at) = '#{date_time}'").count
  end

  class << self
    def get_download_free user, date_time
      user.downloads.where("date(created_at) >= '#{date_time}'").count
    end
  end
end
