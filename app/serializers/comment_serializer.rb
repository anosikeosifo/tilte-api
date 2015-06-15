class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :flagged, :removed, :user_id, :created_at
end
