# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "a name"
    email { "#{rand(100000)}foo@goo.com" }
    password "aaaaaa"

    factory :admin_user do
    	roles [ :admin]
    end

    factory :moderator_user do
    	roles [ :modetator]
    end
    factory :participant_user do
    	roles [ :participant]
    end

  end
end
