class PostSerializer < ActiveModel::Serializer
  attributes :id, :description, :image_url
end
