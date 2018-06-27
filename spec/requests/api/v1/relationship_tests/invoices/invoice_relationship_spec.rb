require 'rails_helper'

context 'get request to /api/v1/invoices/id/transactions' do
    it 'can get all transactions associated with single invoice' do
      id = create(:invoice).id

      get "/api/v1/invoices/#{1}/transactions"

      transactions = JSON.parse(response.body)

      expect(response).to be_successful
      expect(transactions.count).to eq(3)
    end
  end