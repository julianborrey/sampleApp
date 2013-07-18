#file to make a user for testing

FactoryGirl.define do
   factory :user do
      name                  "Paul McCartney"
      email                 "paul@beatles.com"
      password              "strawberry"
      password_confirmation "strawberry"
   end
end
