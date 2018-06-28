require 'rails_helper'

describe 'relationships' do
  it 'returns a collection of associated invoice items' do

    item1 = create(:item)
    item2 = create(:item)
    create(:invoice_item, item: item1)
    create(:invoice_item, item: item1)
    create(:invoice_item, item: item1)
    create(:invoice_item, item: item2)

    get "/api/v1/items/#{item1.id}/invoice_items"

    expect(response).to be_successful
    invoice_items_json = JSON.parse(response.body)

    expect(item1.invoice_items.count).to eq(invoice_items_json.count)
  end

  it 'returns an associated merchant' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    merchant_json = JSON.parse(response.body)
    expect(item.merchant.id).to eq(merchant_json["id"])
  end
end
