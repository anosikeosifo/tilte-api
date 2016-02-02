class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.integer :user_id, index: true
      t.string :provider
      t.string :uid
      t.string :token
      t.timestamps
    end
  end
end
