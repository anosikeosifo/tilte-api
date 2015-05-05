class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :image_url
      t.string :description
      t.references :user, index: true

      t.timestamps
    end
  end
end
