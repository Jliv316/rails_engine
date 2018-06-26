FactoryBot.define do
  factory :merchant do
    name {Faker::Simpsons.unique.character}
  end
end
