class Post < ActiveRecord::Base
  validates :description, presence: true
  belongs_to :user

  def mark_as_removed!
    removed = true
  end
end
