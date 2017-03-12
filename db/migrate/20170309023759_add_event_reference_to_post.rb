class AddEventReferenceToPost < ActiveRecord::Migration[5.0]
  def change
    add_reference(:posts, :event, index: true)
  end
end
