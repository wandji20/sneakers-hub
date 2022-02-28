FactoryBot.define do
  factory :genders do
    name { Faker::Internet.username(specifier: 5..50) }
  end
end