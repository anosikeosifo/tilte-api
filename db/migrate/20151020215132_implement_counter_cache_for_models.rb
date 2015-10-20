class ImplementCounterCacheForModels < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, default: 0

    Post.all.each do |post|
      post.update(comments_count: post.comments.size)
    end

    add_column :users, :posts_count, :integer, default: 0
    add_column :users, :favorites_count, :integer, default: 0

    User.all.each do |user|
      user.update(posts_count: user.posts.length)
      user.update(favorites_count: user.favorites.length)
    end
  end
end
