class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :auth_token, uniqueness: true
  before_create :generate_auth_token!

  def generate_auth_token!
    begin
      self.auth_token = Devise.friendly_token
    end while self.class.exists?(auth_token: auth_token)

  end

  has_many :relationships, foreign_key: "follower_id", dependent: :destroy

  has_many :following, through: :relationships, source: :followed
  has_many :followers, through: :relationships

  def follow(other_user)
    relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
