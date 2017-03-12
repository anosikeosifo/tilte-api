class CreateEventLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :event_locations do |t|
      t.integer :event_id
      t.integer :location_id
    end
  end
end
