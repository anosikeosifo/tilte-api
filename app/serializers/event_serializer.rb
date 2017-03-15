class EventSerializer < ActiveModel::Serializer
  ActiveSupport::JSON::Encoding.time_precision = 0
  attributes :id, :title, :description, :rating, :price, :start_time, :end_time, :event_category_id, :category_name, :attendee_count, :post_count, :created_at
  has_one :organizer #this embeds the related user to the post json reponse
  has_many :locations

  def comments
    object.comments.order(created_at: :desc)
  end

  def is_free
    price == 0.00
  end

  def category_name
    object.event_category.name
  end
end
