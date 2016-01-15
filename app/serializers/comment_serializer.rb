class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :flagged, :removed, :user_id, :user_avatar, :created_at

  has_one :user
  def user_avatar
    object.user.avatar.url
  end
end
