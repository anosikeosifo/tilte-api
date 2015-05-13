# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

20.times do |count|
  user = FactoryGirl.build(:user) #, email: "tilte-user#{count + 1}@gmail.com")
  user.username = user.fullname.gsub(' ', '_').downcase
  user.save
end

#here i seed data for the  user relationships
users = User.all

followers = users[0..7]
following = users[9..15]

followers.each do |follower|
  following.each { |followed_user| follower.follow(followed_user) }
end

#create posts
20.times { FactoryGirl.create :post }