require 'rails_helper'

describe 'Invoices API' do
  before(:all) do
    customer = create(:customer)
    merchant = create(:merchant)

    invoice1 = Invoice.create(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
    invoice2 = Invoice.create(status: "pending", customer_id: customer.id, merchant_id: merchant.id)
    invoice3 = Invoice.create(status: "ordered", customer_id: customer.id, merchant_id: merchant.id)
  end
  context 'get request to /api/v1/invoices' do
    it 'responds with a list of all invoices' do
      binding.pry
      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices.count).to eq(3)
    end
  end
end