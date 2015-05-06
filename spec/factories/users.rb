FactoryGirl.define do
  factory :user do
    fullname { FFaker::Name.name }
    username { FFaker::Internet.user_name }
    email { FFaker::Internet.email }
    password "test1234"
    password_confirmation "test1234"
  end

end
