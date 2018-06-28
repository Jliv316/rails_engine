require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'instance methods' do
    it 'can calculate single merchant revenue' do
      merchant = create(:merchant)
      invoices = create_list(:invoice, 3, merchant: merchant)
      create(:transaction, invoice: invoices[0], result: "Success")
      create(:transaction, invoice: invoices[1], result: "Failed")
      create(:transaction, invoice: invoices[2], result: "Success")
      create(:invoice_item, invoice: invoices[0], unit_price: 1000, quantity: 50)
      create(:invoice_item, invoice: invoices[1], unit_price: 2000, quantity: 50)
      create(:invoice_item, invoice: invoices[2], unit_price: 2500, quantity: 50)

      expect(Money.new((merchant.single_merchant_revenue), "USD").to_s).to eq(Money.new(175000, "USD").to_s)
    end
  end
end
