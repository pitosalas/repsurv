FactoryGirl.define do
  factory :program do
    name "My Program"
    description "Factory program"
    open true
    locked false
    association :moderator, factory: :moderator_user
  end
end