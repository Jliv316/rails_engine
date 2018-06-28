require 'rails_helper'

describe 'Invoice Items Relationship Endpoint' do
  it 'returns the associated invoice' do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    expect(response).to be_successful
    invoice_json = JSON.parse(response.body)
    expect(invoice.id).to eq(invoice_json["id"])
  end

  it 'returns the associated item' do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    expect(response).to be_successful
    item_json = JSON.parse(response.body)
    expect(item.id).to eq(item_json["id"])
  end
end
