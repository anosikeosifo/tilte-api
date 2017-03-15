class EventCategory < ApplicationRecord
  has_many :events

  def self.for_home_view
    includes(:events).where('is_active =? AND is_featured = ? AND events.rating >= 3', true, true).references(:events)
  end
end
