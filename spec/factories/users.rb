FactoryBot.define do
  factory :user do
    name { "name" }
    sequence(:email) { |i| "email#{i}@email.com" }
    password { "password" }
  end
end