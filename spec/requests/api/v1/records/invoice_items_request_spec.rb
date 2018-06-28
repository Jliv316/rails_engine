require 'rails_helper'

describe 'Invoices API' do
  let(:customer){ create(:customer)}
  let(:merchant){ create(:merchant)}
  let(:item){ create(:item)}
  before(:each) do
    invoice = create(:invoice, merchant: merchant, customer: customer)
    @invoice_items = create_list(:invoice_item, 3, invoice: invoice, item: item)
  end

  context 'get request to /api/v1/invoice_items' do
    xit 'responds with a list of all invoice_items' do

      get '/api/v1/invoice_items'

      invoice_items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_items.count).to eq(3)
    end
  end

  context 'get request to /api/v1/invoice_items/id' do
    xit 'can get one invoice_item by id' do
      id = create(:invoice_item).id

      get "/api/v1/invoice_items/#{id}"

      invoice_item = JSON.parse(response.body)

      expect(response).to be_successful
      expect(invoice_item["id"]).to eq(id)
    end
  end

  describe 'invoice_item single finders' do
    xit 'finds one invoice_item by id' do

      get "/api/v1/invoice_items/find?id=#{@invoice_items[0].id}"

      expect(response).to be_successful

      invoice_item = JSON.parse(response.body)

      expect(invoice_item["id"]).to eq(@invoice_items[0].id)
    end

    it 'finds one invoice by unit_price' do
      get "/api/v1/invoice_items/find?unit_price=#{@invoice_items[0].unit_price.to_i}"
      
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items["unit_price"]).to eq(@invoice_items[0].unit_price)
    end

    xit 'finds one invoice by invoice_id' do
      get "/api/v1/invoice_items/find?invoice_id=#{@invoice_items[0].invoice_id}"
      
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items["invoice_id"]).to eq(@invoice_items[0].invoice_id)
    end
    
    xit 'finds one invoice by item_id' do
      get "/api/v1/invoice_items/find?item_id=#{@invoice_items[0].item_id}"
      
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items["item_id"]).to eq(@invoice_items[0].item_id)
    end

    xit 'finds one invoice by quantity' do
      get "/api/v1/invoice_items/find?quantity=#{@invoice_items[0].quantity}"
      
      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items["quantity"]).to eq(@invoice_items[0].quantity)
    end
  end

  describe 'invoice multiple finders' do
    xit 'finds all invoice_items with specific id' do
      get "/api/v1/invoice_items/find_all?id=#{@invoice_items[0].id}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items[0]["id"]).to eq(@invoice_items[0].id)
    end
    
    xit 'finds all invoice_items with specific invoice_id' do
      get "/api/v1/invoice_items/find_all?invoice_id=#{@invoice_items[0].invoice_id}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items[0]["invoice_id"]).to eq(@invoice_items[0].invoice_id)
    end

    xit 'finds all invoice_items with specific item_id' do
      get "/api/v1/invoice_items/find_all?item_id=#{@invoice_items[0].item_id}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items[0]["item_id"]).to eq(@invoice_items[0].item_id)
    end

    xit 'finds all invoice_items with specific quantity' do
      get "/api/v1/invoice_items/find_all?quantity=#{@invoice_items[0].quantity}"

      expect(response).to be_successful

      invoice_items = JSON.parse(response.body)

      expect(invoice_items[0]["quantity"]).to eq(@invoice_items[0].quantity)
    end
  end
end
