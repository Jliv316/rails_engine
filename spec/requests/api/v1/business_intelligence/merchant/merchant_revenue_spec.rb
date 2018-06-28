require 'rails_helper'

describe 'merchant revenue buisness intelligence' do
  it 'returns the total revenue for that merchant across successful transactions' do
    merchant = create(:merchant)
    invoices = create_list(:invoice, 3, merchant: merchant)
    create(:transaction, invoice: invoices[0], result: "Success")
    create(:transaction, invoice: invoices[1], result: "Failed")
    create(:transaction, invoice: invoices[2], result: "Success")
    create(:invoice_item, invoice: invoices[0], unit_price: 1000, quantity: 50)
    create(:invoice_item, invoice: invoices[1], unit_price: 2000, quantity: 50)
    create(:invoice_item, invoice: invoices[2], unit_price: 2500, quantity: 50)

    get "/api/v1/merchants/#{merchant.id}/revenue"

    expect(response).to be_successful
    revenue_json = JSON.parse(response.body)
    expect(revenue_json["revenue"]).to eq(Money.new(175000, "USD").to_s)
  end
end
