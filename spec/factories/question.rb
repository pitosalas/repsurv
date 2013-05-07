# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :question do
  	text { Faker::Lorem.sentence }
  end
end
