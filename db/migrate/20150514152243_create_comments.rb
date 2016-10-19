class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, index:true
      t.integer :like_count, default: 0
      t.references :user, index: true
      t.references :post, index: true
      t.boolean :flagged, default: false
      t.boolean :removed, default: false
      t.timestamps
    end
  end
end
