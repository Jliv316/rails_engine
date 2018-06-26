require 'rails_helper'

describe 'Invoices API' do
  context 'get request to /api/v1/invoices' do
    it 'responds with a list of all invoices' do
      customer = create(:customer)
      merchant = create(:merchant)

      invoice1 = Invoice.create(status: "shipped", customer_id: customer.id, merchant_id: merchant.id)
      invoice2 = Invoice.create(status: "pending", customer_id: customer.id, merchant_id: merchant.id)
      invoice3 = Invoice.create(status: "ordered", customer_id: customer.id, merchant_id: merchant.id)

      get '/api/v1/invoices'

      expect(response).to be_successful
    end
  end
end