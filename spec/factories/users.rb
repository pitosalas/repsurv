# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "a name"
    email { "#{rand(100000)}foo@goo.com" }
    password "aaaaaa"
  end
end
