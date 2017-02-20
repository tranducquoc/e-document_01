class Organization < ApplicationRecord
  has_many :teams, dependent: :destroy
  has_many :group_members, dependent: :destroy
end
