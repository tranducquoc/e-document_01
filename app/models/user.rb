class User < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :downcase_email
  paginates_per Settings.per_page
  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:facebook]
  has_many :documents
  has_many :downloads
  has_many :favorites
  has_many :reads
  has_many :comments
  has_many :reviews
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :user_one_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :user_two_id, dependent: :destroy
  has_many :followings, through: :active_relationships, source: :user_two
  has_many :followers, through: :passive_relationships, source: :user_one
  has_many :active_conversations, class_name: Chatroom.name,
    foreign_key: :host_id, dependent: :destroy
  has_many :passive_conversations, class_name: Chatroom.name,
    foreign_key: :guest_id, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :buycoins
  scope :email_admin, -> () {
    self.select(:id, :email).where(role: :admin)
  }

  enum role: [:member, :admin]
  validates :name , presence: true, length: {maximum: Settings.name_size_max}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.email_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  def slug_candidates
    [
      :name,
      [:name, :email]
    ]
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

  def self.search params_search
    User.all.where("name LIKE ?", "%#{params_search}%")
  end

  def had_conversation? other_user
    self.active_conversations.collect(&:guest).flatten.uniq.include? other_user
  end

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  class << self
    def send_mail_if_not_login
      User.where("last_sign_in_at < ?", Time.now - 1.hour)
    end
  end

  private
  def downcase_email
    self.email = email.downcase
  end
end
