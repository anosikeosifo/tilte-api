FactoryGirl.define do
  factory :comment do
    text { FFaker::Lorem.sentence(word_count=10) }
    like_count 1
    user
    post
  end

end
