class ChangeLikeCountToFavoriteCountForPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :like_count, :favorites_count
  end
end
