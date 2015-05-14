class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :flagged, :removed
end
