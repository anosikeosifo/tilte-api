FactoryGirl.define do
  factory :post do
    image_url "MyString"
    description "Test post description" #{ FFaker::Lorem.sentence(word_count=4) }
    image ""
    removed false
    association event
    user
  end
end
