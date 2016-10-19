class Post < ActiveRecord::Base
  mount_base64_uploader :image, PostUploader
  mount_uploader :image, PostUploader

  attr_accessor :is_favorite, :can_repost, :is_favorite_request
  class_attribute :signed_in_user

  after_initialize :check_favorite, if: :signed_in_user
  after_initialize :can_repost?, if: :signed_in_user

  scope :for_user_feed, ->(user) { where(:user_id => user.following.pluck(:id).push(user.id)).order(created_at: :desc) }
  scope :favorites_of, ->(user) { where(:id => user.favorites.pluck(:post_id)) }
  scope :by_user, ->(user) { where(user_id: user.id) }


  validates :description, presence: true
  belongs_to :user
  has_many :comments
  has_many :repost_relationships
  has_many :reposts, class_name: "Post", through: :repost_relationships, source: :repost, dependent: :destroy

  def mark_as_removed!
    self.removed = true
  end

  def favorite!
    self.increment!(:favorite_count, 1)
  end

  def repost!(reposter_id)
    repost = self.dup
    repost.user_id = reposter_id
    repost.save

    repost = repost_relationships.build(post_id: self.id, repost_id: repost.id, reposter_id: reposter_id, owner_id: self.user_id)
    return repost.save
  end


  def original_post
    RepostRelationship.find(repost_id).original_post if repost_id
  end

  private
    def check_favorite
      @is_favorite = signed_in_user.favorites.pluck(:post_id).include?(id)
    end

    def can_repost?
      @can_repost = (user != signed_in_user)
    end


end
