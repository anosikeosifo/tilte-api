class AddCategoryIdToEvent < ActiveRecord::Migration[5.0]
  def change
    add_reference(:events, :event_category, index: true)
  end
end
