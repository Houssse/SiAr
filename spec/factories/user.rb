FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "johndoe#{n}@example.com" }
    password { "password" }
    name { "John Doe" }
  end
end
