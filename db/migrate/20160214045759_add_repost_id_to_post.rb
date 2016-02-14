class AddRepostIdToPost < ActiveRecord::Migration
  def change
    add_column :posts, :repost_id, :integer
  end
end
