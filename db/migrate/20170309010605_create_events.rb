class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.decimal :price, default: 0.00
      t.string :start_time, limit: 15
      t.string :end_time, limit: 15
    end

    add_reference(:events, :organizer, foreign_key: { to_table: :users }, index: true)
  end
end
