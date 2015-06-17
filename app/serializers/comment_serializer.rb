class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :flagged, :removed, :user_id, :user_avatar, :created_at
end
