class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true

  scope :with_avatar, -> {
    includes(:user).all.each do |comment|
      comment.user_avatar = comment.user.avatar.url
    end
  }

  attr_accessor :user_avatar

  def remove!
    self.removed = true
  end
end
