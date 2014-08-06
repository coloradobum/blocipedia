# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "joe@blow.com"
    password "joespassword"
    password_confirmation "joespassword"
  end
end
