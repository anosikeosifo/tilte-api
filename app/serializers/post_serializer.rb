class PostSerializer < ActiveModel::Serializer
  ActiveSupport::JSON::Encoding.time_precision = 0
  attributes :id, :description, :image_url, :comments_count, :favorites_count, :is_favorite, :created_at
  has_one :user #this embeds the related user to the post json reponse
  has_many :comments
end
