FactoryBot.define do
  factory :invoice do
    status "Shipped"
    customer_id 1
    merchant_id 1
  end
end
