FactoryGirl.define do
  factory :user do
    email "joe@blow.com"
    password "joespassword"
    password_confirmation "joespassword"

    trait :confirmed do
      after(:create) do |user|
        user.confirm!
      end
    end

    trait :premium do
      confirmed
      is_premium_user true
    end
  end
end
