class Event < ActiveRecord::Base
  # mount_base64_uploader :image, EventUploader
  # mount_uploader :image, EventUploader

  scope :created_by, ->(user) { where(user_id: user.id) }

  belongs_to :event_category
  belongs_to :organizer, class_name: 'User'
  has_many :posts
  has_many :event_attendees
  has_many :attendees, through: :event_attendees

  has_many :event_locations
  has_many :locations, through: :event_locations
end
