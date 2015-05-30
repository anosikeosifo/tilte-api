class Post < ActiveRecord::Base
  mount_base64_uploader :image_url, PostUploader
  validates :description, presence: true
  belongs_to :user
  has_many :comments

  def mark_as_removed!
    self.removed = true
  end
end
