class EventCategory < ApplicationRecord
  has_many :events

  def self.for_home_view
    includes(:events).where('is_active=1 AND is_featured=1 AND events.rating > 4').references(:events)
  end
end
