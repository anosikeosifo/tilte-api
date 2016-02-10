class UserSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :email, :username, :fullname, :auth_token, :created_at, :posts_count, :favorites_count, :can_be_followed, :profile_photo_url, :updated_at

  def can_be_followed
    object.try(:can_be_followed)
  end

  has_many :posts
end
