class UserSerializer < ActiveModel::Serializer
  embed :ids
  attributes :id, :email, :username, :fullname, :auth_token, :created_at, :updated_at

  has_many :posts
end
