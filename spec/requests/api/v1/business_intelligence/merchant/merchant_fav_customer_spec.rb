require 'rails_helper'

describe 'Merchant items buisness intelligence' do
  it 'returns merchant with most sold items' do
    customer1 = create(:customer)
    customer2 = create(:customer)

    merchant1 = create(:merchant)

    invoice1 = create(:invoice, merchant: merchant1, customer: customer2)
    invoice2 = create(:invoice, merchant: merchant1, customer: customer2)
    invoice3 = create(:invoice, merchant: merchant1, customer: customer1)

    transaction1 = create(:transaction, invoice: invoice1, result: "success")
    transaction2 = create(:transaction, invoice: invoice2, result: "success")
    transaction3 = create(:transaction, invoice: invoice3, result: "success")


    get "/api/v1/merchants/#{merchant1.id}/favorite_customer"

    expect(response).to be_successful
    fav_customer = JSON.parse(response.body)

    expect(fav_customer["id"]).to eq(customer2.id)
  end

end
