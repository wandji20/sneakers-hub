FactoryBot.define do
  factory :sneakers do
    brand
    gender
    name { Faker::Name.name }
    price { Faker.Number.decimal }
    release_date { Faker::Date.between(from: 3.months.ago, to: 1.year.from_now) }
    shoe_id { Faker::Internet.uuid }
    title { Faker::Name.name }
    image_url { Faker::Internet.url }
  end
end
