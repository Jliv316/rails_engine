require 'rails_helper'

describe 'Items API' do
  let(:merchant){ create(:merchant)}
  before(:each) do
    @items = create_list(:item, 3, merchant: merchant)
  end

  context 'get request to /api/v1/items' do
    it 'responds with a list of all items' do

      get '/api/v1/items'

      items = JSON.parse(response.body)

      expect(response).to be_successful
      expect(items.count).to eq(3)
    end
  end

  context 'get request to /api/v1/items/id' do
    it 'can get one item by id' do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item_json = JSON.parse(response.body)

      expect(response).to be_successful
      expect(item_json["id"]).to eq(id)
    end
  end

  describe 'item single finders' do
    it 'finds one item by id' do

      get "/api/v1/items/find?id=#{@items[0].id}"

      expect(response).to be_successful

      item_json = JSON.parse(response.body)

      expect(item_json["id"]).to eq(@items[0].id)
    end

    it 'finds one item by name' do
      get "/api/v1/items/find?name=#{@items[0].name}"
      
      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item["name"]).to eq(@items[0].name)
    end

     it 'finds one item by name case insenstive' do
      get "/api/v1/items/find?name=#{@items[0].name.upcase}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item["name"]).to eq(@items[0].name)
    end

    it 'finds one item by unit_price' do
      get "/api/v1/items/find?unit_price=#{@items[0].unit_price}"
      
      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item["unit_price"]).to eq(@items[0].unit_price)
    end

    it 'finds one item by merchant id' do
      get "/api/v1/items/find?merchant_id=#{@items[0].merchant_id}"
      
      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item["merchant_id"]).to eq(@items[0].merchant_id)
    end
  end

  describe 'item multiple finders' do
    it 'finds all items with specific id' do
      get "/api/v1/items/find_all?id=#{@items[0].id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item[0]["id"]).to eq(@items[0].id)
    end

    it 'finds all items with specific name' do
      get "/api/v1/items/find_all?name=#{@items[0].name}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item.count).to eq(3)
    end

    it 'finds all items with specific name' do
      get "/api/v1/items/find_all?merchant_id=#{@items[0].merchant_id}"

      expect(response).to be_successful

      item = JSON.parse(response.body)

      expect(item.count).to eq(3)
    end
  end
end
