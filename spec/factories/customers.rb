FactoryBot.define do
  factory :customer do
    first_name {Faker::Simpsons.unique.character}
    last_name {Faker::Simpsons.unique.character}
  end
end
