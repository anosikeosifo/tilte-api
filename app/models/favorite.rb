class Favorite < ActiveRecord::Base
  belongs_to :post
  belongs_to :user, counter_cache: true
end
