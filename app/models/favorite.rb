class Favorite < ActiveRecord::Base
  belongs_to :post, counter_cache: true
  belongs_to :user, counter_cache: true
  validate :unique_user_favorite_per_post, on: :create


  private
    def unique_user_favorite_per_post
      if Favorite.exists?(user_id: user_id, post_id: post_id)
        errors.add :post, "has already been marked as favorite by you."
      end
    end

end
