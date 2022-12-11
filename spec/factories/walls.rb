FactoryBot.define do
  factory :wall do
    association(:user)
  end
end