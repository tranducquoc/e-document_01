class Coin < ApplicationRecord
  belongs_to :user
  has_many :buycoins

  enum status: [:available, :bought, :checked, :used]

  class << self
    def get_coin value
      Coin.where(status: :available, value: value).order(created_at: :desc).first
    end
  end
end
