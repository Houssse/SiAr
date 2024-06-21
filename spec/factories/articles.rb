FactoryBot.define do
  factory :article do
    title { "Sample Article Title" }
    content { "Sample Article Content" }
    association :user  
  end
end
