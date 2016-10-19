class AddRepostDataToPost < ActiveRecord::Migration
  def change
    add_column :posts, :repost_id, :integer, index: true
    add_column :posts, :reposts_count, :integer, default: 0
  end
end
