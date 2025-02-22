FactoryBot.define do
    factory :product do
      title { "Sample Product" }
      description { "A test product description" }
      price { "10.99" }
      url { "https://example.com/product" }
      last_fetched_at { Time.current }
      association :category
    end
  end
  