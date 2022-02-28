FactoryBot.define do
  factory :brands do
    name { Faker::Name.username(specifier: 5..50) }
  end
end