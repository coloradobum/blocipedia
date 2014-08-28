FactoryGirl.define do
  factory :user do
    email "joe@blow.com"
    password "joespassword"
    password_confirmation "joespassword"

    trait :confirmed do
      # before(:create) do |user|
      #   user.skip_confirmation!
      # end
      confirmed_at Time.now
    end

    trait :confirmed2 do
      confirmed
    end

    trait :premium do
      is_premium_user true
    end
  end
end
