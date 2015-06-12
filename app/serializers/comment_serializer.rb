class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :flagged, :removed, :user_id
end
