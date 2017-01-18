class Buycoin < ApplicationRecord
  belongs_to :user
  belongs_to :coin

  enum status: [:waiting, :checked]
end
