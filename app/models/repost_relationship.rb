class RepostRelationship < ActiveRecord::Base
  belongs_to :original_post, class_name: "Post", foreign_key: "post_id"
  belongs_to :repost, class_name: "Post", foreign_key: "repost_id"
  belongs_to :reposter, class_name: "User", foreign_key: "reposter_id"
  belongs_to :owner, class_name: "User", foreign_key: "owner_id"

  after_save :update_post_with_repost_data

  def update_post_with_repost_data
    Post.find(repost_id).update_attribute(:repost_id, id)
  end
end
