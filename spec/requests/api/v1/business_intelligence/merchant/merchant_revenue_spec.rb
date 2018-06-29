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

  it 'returns the total revenue for that merchant across successful transactions by a specific date' do
    merchant = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant, created_at: "2015-04-15 12:50:00 UTC")
    invoice2 = create(:invoice, merchant: merchant)
    invoice3 = create(:invoice, merchant: merchant)
    create(:transaction, invoice: invoice1, result: "Success")
    create(:transaction, invoice: invoice2, result: "Failed")
    create(:transaction, invoice: invoice3, result: "Success")
    create(:invoice_item, invoice: invoice1, unit_price: 1000, quantity: 50)
    create(:invoice_item, invoice: invoice2, unit_price: 2000, quantity: 50)
    create(:invoice_item, invoice: invoice3, unit_price: 2500, quantity: 50)

    get "/api/v1/merchants/#{merchant.id}/revenue?date=#{invoice1.created_at}"

    expect(response).to be_successful
    revenue_json = JSON.parse(response.body)
    expect(revenue_json["revenue"]).to eq(Money.new(50000, "USD").to_s)
  end


  it 'returns merchants with the most revenue' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant1)
    invoice3 = create(:invoice, merchant: merchant2)
    create(:transaction, invoice: invoice1, result: "Success")
    create(:transaction, invoice: invoice2, result: "Failed")
    create(:transaction, invoice: invoice3, result: "Success")
    create(:invoice_item, invoice: invoice1, unit_price: 10000, quantity: 50)
    create(:invoice_item, invoice: invoice2, unit_price: 20000, quantity: 100)
    create(:invoice_item, invoice: invoice3, unit_price: 2500, quantity: 50)

    get '/api/v1/merchants/most_revenue?quantity=1'

    expect(response).to  be_successful
    merchants_json = JSON.parse(response.body)
    expect(merchants_json.first["id"]).to eq(merchant1.id)
  end

  it 'returns the total revenue for all merchants across successful transactions by a specific date' do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    invoice1 = create(:invoice, merchant: merchant, created_at: "2015-04-15 12:50:00 UTC")
    invoice2 = create(:invoice, merchant: merchant2, created_at: "2014-04-15 12:50:00 UTC")
    create(:transaction, invoice: invoice1, result: "Success")
    create(:transaction, invoice: invoice2, result: "Success")
    create(:invoice_item, invoice: invoice1, unit_price: 10, quantity: 50)
    create(:invoice_item, invoice: invoice2, unit_price: 2000, quantity: 50)

    get "/api/v1/merchants/revenue?date=#{invoice1.created_at}"

    expect(response).to be_successful
    revenue_json = JSON.parse(response.body)
    expect(revenue_json["total_revenue"]).to eq(Money.new(500, "USD").to_s)
  end
end
