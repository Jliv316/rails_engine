require 'rails_helper'

describe 'Invoices API' do
  let(:customer){ create(:customer)}
  let(:merchant){ create(:merchant)}
  before(:each) do
    @invoices = create_list(:invoice, 3, merchant: merchant, customer: customer)
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

  describe 'invoice single finders' do
    it 'finds one invoice by id' do

      get "/api/v1/invoices/find?id=#{@invoices[0].id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice["id"]).to eq(@invoices[0].id)
    end

    it 'finds one invoice by status' do
      get "/api/v1/invoices/find?status=#{@invoices[0].status}"
      
      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice["status"]).to eq(@invoices[0].status)
    end

     it 'finds one invoice by status case insenstive' do
      get "/api/v1/invoices/find?status=#{@invoices[0].status.upcase}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice["status"]).to eq(@invoices[0].status)
    end

    it 'finds one invoice by customer id' do
      get "/api/v1/invoices/find?customer_id=#{@invoices[0].customer_id}"
      
      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice["customer_id"]).to eq(@invoices[0].customer_id)
    end

    it 'finds one invoice by merchant id' do
      get "/api/v1/invoices/find?merchant_id=#{@invoices[0].merchant_id}"
      
      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice["merchant_id"]).to eq(@invoices[0].merchant_id)
    end
  end

  describe 'invoice multiple finders' do
    it 'finds all invoices with specific id' do
      get "/api/v1/invoices/find_all?id=#{@invoices[0].id}"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice[0]["id"]).to eq(@invoices[0].id)
    end

    it 'finds all invoices with specific status' do
      get "/api/v1/invoices/find_all?status=shipped"

      expect(response).to be_successful

      invoice = JSON.parse(response.body)

      expect(invoice.count).to eq(3)
    end
  end
end
