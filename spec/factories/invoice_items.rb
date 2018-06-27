FactoryBot.define do
  factory :invoice_item do
    invoice
    item
    quantity {Faker::Number.between(1, 20)}
    unit_price 9.99
    created_at "2015-07-30 12:50:00 UTC"
    updated_at "2015-07-30 12:50:00 UTC"
  end
end
