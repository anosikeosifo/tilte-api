class AddRatingToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :rating, :integer, index: true, default: 0
  end
end
