class Favorite < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, counter_cache: true

  validates :user, uniqueness: { scope: :post, message: "You already favorited this post" }
end
