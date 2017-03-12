class CreateEventAttendees < ActiveRecord::Migration[5.0]
  def change
    create_table :event_attendees, id: false do |t|
      t.integer :event_id, index: true
      t.integer :attendee_id, index: true
    end
  end
end
