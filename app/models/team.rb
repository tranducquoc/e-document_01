class Team < ApplicationRecord
  belongs_to :organization
  has_many :group_members, dependent: :destroy
end
