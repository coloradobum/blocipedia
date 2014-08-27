FactoryGirl.define do
  factory :wiki do
    title "MyString"
    body "MyText"
  end
  
  trait :private do
      after(:create) do |wiki|
        wiki.private = true
      end
    end
end
