class Share < ApplicationRecord
  belongs_to :document

  enum share_type: [:organization, :team, :user]

  Share.share_types.keys.each do |type|
    eval "belongs_to :#{type}, ->{where share_type: #{type}}"
  end
  scope :share_organization, ->{where share_type: Share.share_types[:organization]}
  scope :share_team, ->{where share_type: Share.share_types[:team]}
  scope :share_user, ->{where share_type: Share.share_types[:user]}
end
