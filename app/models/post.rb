class Post < ActiveRecord::Base
  mount_base64_uploader :image, PostUploader
  mount_uploader :image, PostUploader

  validates :description, presence: true
  belongs_to :user
  has_many :comments

  def mark_as_removed!
    self.removed = true
  end

  def like!
    self.increment!(:like_count, 1)
  end
end
