class Post < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :user
  has_many :comments

  def mark_as_removed!
    self.removed = true
  end
end
