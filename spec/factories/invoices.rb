FactoryBot.define do
  factory :invoice do
    merchant
    customer
    status "Shipped"
    created_at "2015-07-30 12:50:00 UTC"
    updated_at "2015-07-30 12:50:00 UTC"
  end
end
