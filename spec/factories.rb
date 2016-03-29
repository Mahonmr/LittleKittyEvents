FactoryGirl.define do
  factory :club do
    name 'Little Kitty Club'
    location '1234 SW Kitty Cat Ln, Portland OR'
  end

  factory :user do
    email 'lk@me.com'
    password 'nike12345'
    first_name 'Little'
    last_name 'Kitty'
  end
end
