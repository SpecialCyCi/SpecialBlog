# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link, :class => 'Links' do
    name "MyString"
    logo "MyString"
    url "MyString"
  end
end
