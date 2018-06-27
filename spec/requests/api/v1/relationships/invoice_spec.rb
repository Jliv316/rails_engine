require 'rails_helper'

describe 'relationships' do
  let(:customer){ create(:customer)}
  let(:merchant){ create(:merchant)}
  it 'returns a collection of transactions' do
    invoices = create_list(:invoice, 5,  merchant: merchant, customer: customer)
    create(:transaction, invoice: invoices[0])
    create(:transaction, invoice: invoices[0])

    get "/api/v1/invoices/#{invoices[0].id}/transactions"

    expect(response).to be_successful

    transactions_json = JSON.parse(response.body)
    expect(invoices[0].transactions.count).to eq(transactions_json.count)
  end

  # it 'returns a collection of transactions' do
  #   invoices = create_list(:invoice, 5)
  #   create(:invoice_item, invoice: invoices[0])
  #   create(:invoice_item, invoice: invoices[0])
  #
  #   get "/api/v1/invoices/#{invoices[0].id}/invoice_items"
  #
  #   expect(response).to be_successful
  # end
end
