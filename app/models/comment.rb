class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true
  validates :post_id, :user_id,  presence:true

  attr_accessor :user_avatar

  def remove!
    removed = true
  end
end
