FactoryBot.define do
  factory :item do
    merchant
    name Faker::StarWars.specie
    description Faker::StarWars.wookiee_sentence
    unit_price 1000
  end
end
