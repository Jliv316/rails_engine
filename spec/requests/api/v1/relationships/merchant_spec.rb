require 'rails_helper'

describe 'Merchant Relationship Endpoints' do
  it 'returns a collection of items associated with that merchant' do
    merchant = create(:merchant)
    items = create_list(:item, 5, merchant: merchant)
    
    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    items_json = JSON.parse(response.body)

    expect(items_json.count).to eq(5)
  end

  it 'returns a collection of invoices associated with that merchant from their known orders' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoices = create_list(:invoice, 5, merchant: merchant, customer: customer)
    
    get "/api/v1/merchants/#{merchant.id}/invoices"

    expect(response).to be_successful

    invoices_json = JSON.parse(response.body)

    expect(invoices_json.count).to eq(5)
  end
end