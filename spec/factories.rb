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

    trait :with_club do
      after(:create) do |user, club = create(:club)|
        club.club_users.create(user: user, manager_id: user.id)
      end
    end
  end
end
