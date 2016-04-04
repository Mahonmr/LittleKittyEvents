FactoryGirl.define do
  factory :club do
    name 'Little Kitty Club'
    location '1234 SW Kitty Cat Ln, Portland OR'
  end

  factory :user do
    sequence :email do |n|
      "lk#{n}@.me.com"
    end
    password 'nike12345'
    first_name 'Little'
    last_name 'Kitty'
    role 'athlete'

    trait :admin do
      after(:build) { |user| user.role = 'admin' }
    end
  end
end
