class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  paginates_per Settings.per_page
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  has_many :documents, class_name: Document.name, foreign_key: :user_id
  has_many :downloads, class_name: Download.name, foreign_key: :user_id
  has_many :favorites, class_name: Favorite.name, foreign_key: :user_id
  has_many :reads, class_name: Read.name, foreign_key: :user_id
  has_many :comments, class_name: Comment.name, foreign_key: :user_id
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :user_one_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :user_two_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :user_two
  has_many :followers, through: :passive_relationships, source: :user_one

  def current_user? user
    user == current_user
  end

  def add_friend other_user
    active_relationships.create user_two_id: other_user.id
  end

  def un_friend other_user
    active_relationships.find_by(user_two_id: other_user.id).destroy
  end

  def friendlist? other_user
    followings.include? other_user
  end

  def friends
    friends = followers.compact
    friends << followings
  end

  def relationships
    relationships = active_relationships.compact
    relationships << passive_relationships
  end

  def is_friend? other_user
    self.friends.include? other_user
  end
end
