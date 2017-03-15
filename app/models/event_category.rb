class EventCategory < ApplicationRecord
  has_many :events

  def self.for_home_view
    includes(:events).where('is_active IS 1 AND is_featured IS 1 AND events.rating >= 3').references(:events)
  end
end
