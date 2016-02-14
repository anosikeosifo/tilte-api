class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true
  before_create :generate_auth_token!

  attr_accessor :can_be_followed

  def generate_auth_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)
  end

  has_many :posts, dependent: :destroy

  has_many :active_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :passive_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships
  has_many :identities
  has_many :favorites
  has_many :favorite_posts, through: :favorites, class_name: "Post"
  has_many :repost_relationships
  has_many :reposts, class_name: "Post", through: :repost_relationships, source: :owner, dependent: :destroy

  def follow!(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def get_followers
    updated_followers = followers.includes(:posts).each { |follower| follower.can_be_followed_by(self) }
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def feed
    Post.for_user_feed(self)
  end

  def favorite_posts
    Post.favorites_of(self)
  end

  def can_be_followed_by(user)
    @can_be_followed = user.following.pluck(:id).exclude?(self.id)
  end
end
