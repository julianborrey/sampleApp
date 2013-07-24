#file to make a user for testing

FactoryGirl.define do
   factory :user do
      sequence(:name)  { |n| "Person #{n}" }
      sequence(:email) { |n| "person_#{n}@example.com"}
      password              "strawberry"
      password_confirmation "strawberry"

      factory :admin do
         admin true
      end
   end
end
