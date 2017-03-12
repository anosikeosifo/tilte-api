class AddTimstampsToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :created_at, :string
    add_column :events, :updated_at, :string
  end
end
