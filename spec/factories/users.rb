FactoryGirl.define do
  factory :user do
    email "joe@blow.com"
    password "joespassword"
    password_confirmation "joespassword"

    trait :confirmed do
      confirmed_at Time.now
    end

    trait :premium do
      is_premium_user true
    end
  end
end
