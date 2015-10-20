class UserSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :email, :username, :fullname, :auth_token, :created_at, :posts_count, :favorites_count, :updated_at

  has_many :posts
end
