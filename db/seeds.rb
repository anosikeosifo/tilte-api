# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

30.times do |count|
  user = FactoryGirl.build(:user) #, email: "tilte-user#{count + 1}@gmail.com")
  user.username = user.fullname.gsub(' ', '_').downcase
  user.save
end
users = User.all
#
#
['Fashion', 'Religion', 'Sport', 'Art', 'Technology', 'Social Good'].each do |categoryName|
  EventCategory.create!({
    name: categoryName,
    description: "#{ categoryName }'s description here.",
    is_featured: true,
    is_active: true,
  })
end
event_categories = EventCategory.all

20.times do |count|
  Event.create({
    title: "Test event #{ count }",
    description: "description for event #{count}",
    start_time: DateTime.now.to_i,
    end_time: DateTime.now.to_i,
    organizer: users.sample,
    event_category: event_categories.sample,
    rating: [3, 4, 5].sample
  })
end
events = Event.all

#here i seed data for the  user relationships

followers = users[0..7]
following = users[15..28]

followers.each do |follower|
  following.each { |followed_user| follower.follow!(followed_user) }
end

#create posts
20.times do |count|
  Post.create(
    image_url: "MyString",
    description: "Test post description #{ count }", #{ FFaker::Lorem.sentence(word_count=4) }
    image: "",
    removed: false,
    event: events.sample,
    user: users.sample
  )
end

#create 4 comments each for 10 post
Post.first(10).each do |post|
  4.times { FactoryGirl.create(:comment, post_id: post.id) }
end
