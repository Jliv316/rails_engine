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

  it 'returns a collection of associated invoice items' do
    invoices = create_list(:invoice, 5,  merchant: merchant, customer: customer)
    create(:invoice_item, invoice: invoices[0])
    create(:invoice_item, invoice: invoices[0])


    get "/api/v1/invoices/#{invoices[0].id}/invoice_items"

    expect(response).to be_successful
    invoice_items_json = JSON.parse(response.body)
    expect(invoices[0].invoice_items.count).to eq(invoice_items_json.count)
  end

  it 'returns a collection of associated items' do
    invoices = create_list(:invoice, 5,  merchant: merchant, customer: customer)
    create(:item, merchant: invoices[0].merchant)
    create(:item, merchant: invoices[0].merchant)

    get "/api/v1/invoices/#{invoices[0].id}/items"
    expect(response).to be_successful
    items_json = JSON.parse(response.body)
    expect(invoices[0].items.count).to eq(items_json.count)
  end

  it 'returns the associated customer' do
    invoices = create_list(:invoice, 5,  merchant: merchant, customer: customer)

    get "/api/v1/invoices/#{invoices[0].id}/customer"

    expect(response).to be_successful
    customer_json = JSON.parse(response.body)
    expect(invoices[0].customer['first_name']).to eq(customer_json['first_name'])
    expect(invoices[0].customer['last_name']).to eq(customer_json['last_name'])
  end

  it ' returns the associated merchant' do
    invoices = create_list(:invoice, 5,  merchant: merchant, customer: customer)

    get "/api/v1/invoices/#{invoices[0].id}/merchant"

    expect(response).to be_successful
    merchant_json = JSON.parse(response.body)
    expect(invoices[0].merchant['name']).to eq(merchant_json['name'])
  end
end
