class Post < ActiveRecord::Base
  mount_base64_uploader :image, PostUploader
  mount_uploader :image, PostUploader

  attr_accessor :is_favorite
  class_attribute :signed_in_user

  after_initialize :check_favorite

  scope :for_user_feed, ->(user) { where(:user_id => user.following.pluck(:id).push(user.id)) }
  scope :by_user, ->(user) { where(user_id: user.id) }


  validates :description, presence: true
  belongs_to :user
  has_many :comments

  def mark_as_removed!
    self.removed = true
  end

  def like!
    self.increment!(:like_count, 1)
  end

  def check_favorite
    @is_favorite = signed_in_user.favorites.include?(self)
  end
end
