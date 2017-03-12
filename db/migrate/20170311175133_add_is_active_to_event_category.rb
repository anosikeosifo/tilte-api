class AddIsActiveToEventCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :event_categories, :is_active, :boolean, default: false
    add_column :event_categories, :is_featured, :boolean, default: false
  end
end
