class Imageslide < ApplicationRecord
  mount_uploader :image, ImageUploader

  enum status: [:disable, :enable]

  def self.search params_search
    Imageslide.all.where("image LIKE ?", "%#{params_search}%")
  end
end
