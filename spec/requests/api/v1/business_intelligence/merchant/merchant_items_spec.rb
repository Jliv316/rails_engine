require 'rails_helper'

describe 'Merchant items buisness intelligence' do
  it 'returns merchant with most sold items' do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    invoice1 = create(:invoice, merchant: merchant1)
    invoice2 = create(:invoice, merchant: merchant2)

    item1 = create(:item, merchant: merchant1)
    item2 = create(:item, merchant: merchant2)

    invoice_item1 = create(:invoice_item, invoice: invoice1, quantity: 1, item: item1)
    invoice_item2 = create(:invoice_item, invoice: invoice2, quantity: 10,  item: item2)

    transaction1 = create(:transaction, invoice: invoice1, result: "success")
    transaction2 = create(:transaction, invoice: invoice2, result: "success")


    get "/api/v1/merchants/most_items?quantity=#{2}"

    expect(response).to be_successful
    merchant_list_json = JSON.parse(response.body)
    expect(merchant_list_json.first["id"]).to eq(merchant2.id)
  end

end
