class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def remove!
    self.removed = true
  end
end
