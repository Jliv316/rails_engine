require 'rails_helper'

describe 'Customer api' do
  let(:merchant){ create(:merchant)}
  it 'returns a collection of associated invoices' do
    customer = create(:customer)
    create_list(:invoice, 3, merchant: merchant, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
  end

  it 'returns a collection of associated transactions' do
    customer = create(:customer)
    invoices = create_list(:invoice, 3, merchant: merchant, customer: customer)
    transactions = create_list(:transaction, 3, invoice: invoices[0])

    get "/api/v1/customers/#{customer.id}/transactions"

    transactions_json = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions_json.count).to eq(3)
  end
end