require 'rails_helper'

describe 'Invoices API' do
  let(:customer){ create(:customer)}
  let(:merchant){ create(:merchant)}
  before(:each) do
    invoices = create_list(:invoice, 3, merchant: merchant, customer: customer)
  end

  context 'get request to /api/v1/invoices' do
    it 'responds with a list of all invoices' do

      get '/api/v1/invoices'

      invoices = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoices.count).to eq(3)
    end
  end

  context 'get request to /api/v1/invoices/id' do
    it 'can get one invoice by id' do
      id = create(:invoice, merchant: merchant, customer: customer).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice["id"]).to eq(id)
    end
  end
end
