class PostSerializer < ActiveModel::Serializer
  attributes :id, :description, :image_url, :removed
  has_one :user #this embeds the related user to the post json reponse
  has_many :comments
end
