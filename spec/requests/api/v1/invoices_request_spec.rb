require 'rails_helper'

describe 'Invoices API' do
  before(:all) do
    customer = create(:customer)
    merchant = create(:merchant)

    invoices = create_list(:invoice, 3)
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
      id = create(:invoice).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice["id"]).to eq(id)
    end
  end
  
  context 'get request to /api/v1/invoices/id' do
    it 'can get one invoice by id' do
      id = create(:invoice).id

      get "/api/v1/invoices/#{id}"

      invoice = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice["id"]).to eq(id)
    end
  end
end