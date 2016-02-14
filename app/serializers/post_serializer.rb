class PostSerializer < ActiveModel::Serializer
  ActiveSupport::JSON::Encoding.time_precision = 0
  attributes :id, :description, :image_url, :comments_count, :favorites_count, :is_favorite, :created_at
  has_one :user #this embeds the related user to the post json reponse
  has_many :comments
  has_one :repost_details

  def comments
    object.comments.order(created_at: :desc)
  end

  def repost_details
    if object.repost_id.present?
      { "reposter": "#{ object.repost.reposter }", "created_at": "#{ object.repost.created_at }"  }
    end
  end
end
