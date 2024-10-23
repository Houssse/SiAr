FactoryBot.define do
  factory :like do
    user { nil }
    likeable { nil }
    like_type { 1 }
  end
end
