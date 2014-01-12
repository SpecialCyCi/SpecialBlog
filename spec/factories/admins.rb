# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    email "testing@gmail.com"
    password "testingabc"
  end
end
