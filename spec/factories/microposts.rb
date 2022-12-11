FactoryBot.define do
  factory :micropost do
    body { "body" }
    association(:user)
    association(:wall)
  end
end