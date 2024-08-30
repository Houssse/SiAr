FactoryBot.define do
  factory :comment do
    user { nil }
    article { nil }
    body { "MyText" }
    parent_id { 1 }
  end
end
