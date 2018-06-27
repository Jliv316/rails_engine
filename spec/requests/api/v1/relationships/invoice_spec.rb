require 'rails_helper'

describe 'relationships' do
  it 'returns a collection of transactions' do
    invoices = create_list(:invoice, 5)
    create(:transaction, invoice: invoices[0])
    create(:transaction, invoice: invoices[0])

    get "/api/v1/invoices/#{invoices[0].id}/transactions"

    expect(response).to be_successful

    transactions_json = JSON.parse(response.body)
    expect(invoices[0].transactions.count).to eq(transactions_json.count)
  end
end
