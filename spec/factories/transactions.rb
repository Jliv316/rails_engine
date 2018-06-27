FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number {Faker::Number.between(10000000000000, 999999999999999)}
    credit_card_expiration_date "01/2021"
    result "Success"
  end
end
