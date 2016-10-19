class AddRemovedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :removed, :boolean, default: false
  end
end
