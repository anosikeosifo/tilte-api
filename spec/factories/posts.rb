FactoryGirl.define do
  factory :post do
    image_url "MyString"
    description { FFaker::Lorem.sentence(word_count=4) }
    user
  end

end
