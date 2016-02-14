class CreateRepostRelationships < ActiveRecord::Migration
  def change
    create_table :repost_relationships do |t|
      t.integer :reposter_id, index: true
      t.integer :owner_id, index: true
      t.integer :post_id, index: true
      t.integer :repost_id, index: true
      t.timestamps
    end
  end
end
