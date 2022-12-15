FactoryBot.define do
  factory :micropost do
    body { "body" }
    likes_count { 0 }
    association(:user)
    association(:wall)
  end
end