class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :fullname, :auth_token, :created_at, :updated_at
end
