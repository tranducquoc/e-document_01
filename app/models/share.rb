class Share < ApplicationRecord
  belongs_to :document

  enum share_type: [:organization, :team, :user]

  Share.share_types.keys.each do |type|
    eval "belongs_to :#{type}, ->{where share_type: #{type}}"
    eval "scope :share_#{type}, ->{where share_type: #{type}}"
  end
end
