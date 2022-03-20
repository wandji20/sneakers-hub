FactoryBot.define do
  factory :order_items do
    sneaker
    quantity { Faker::Number.number }
  end
end
