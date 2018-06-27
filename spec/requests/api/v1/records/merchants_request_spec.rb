require 'rails_helper'

describe 'Merchants API' do
  it 'sends a list of merchants' do
    create_list(:merchant, 5)

    get '/api/v1/merchants.json'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants.count).to eq(5)
  end

  it 'sends one merchant by its id' do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}.json"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  describe 'merchant finders' do
    it 'finds one merchant by id' do
      merchants = create_list(:merchant, 5)

      get "/api/v1/merchants/find?id=#{merchants[0].id}"

      expect(response).to be_successful

      merchants_json = JSON.parse(response.body)

      expect(merchants_json["id"]).to eq(merchants[0].id)
    end

    it 'finds one merchant by name' do
      merchants = create_list(:merchant, 5)

      get "/api/v1/merchants/find?name=#{merchants[0].name}"

      expect(response).to be_successful

      merchants_json = JSON.parse(response.body)

      expect(merchants_json["name"]).to eq(merchants[0].name)
    end

    it 'finds one merchant by name case insenstive' do
      merchants = create_list(:merchant, 5)

      get "/api/v1/merchants/find?name=#{merchants[0].name.upcase}"

      expect(response).to be_successful

      merchants_json = JSON.parse(response.body)

      expect(merchants_json["name"]).to eq(merchants[0].name)
    end

    it 'finds all merchants by id' do
      merchants = create_list(:merchant, 5)

      get "/api/v1/merchants/find_all?id=#{merchants[0].id}"

      expect(response).to be_successful
      merchants_json = JSON.parse(response.body)
      expect(merchants_json.class).to eq(Array)
      expect(merchants_json.count).to eq(1)
    end

    it 'finds all merchants by name' do
      merchants = create_list(:merchant, 5)

      get "/api/v1/merchants/find_all?name=#{merchants[0].name}"

      expect(response).to be_successful
      merchants_json = JSON.parse(response.body)
      expect(merchants_json.count).to eq(1)
    end

    it 'finds a random merchant' do
      merchants = create_list(:merchant, 5)

      get "/api/v1/merchants/random.json"

      expect(response).to be_successful
      random_merchant = JSON.parse(response.body)
      expect(merchants.map{ |merchant| merchant.name.include?(random_merchant["name"])}).to be_truthy
    end

    it 'finds a merchant by created_at' do
      merchant1 = create(:merchant, created_at: "2015-07-30 12:50:00 UTC")
      merchant2 = create(:merchant)

      get "/api/v1/merchants/find?created_at=#{merchant1.created_at}"

      expect(response).to be_successful
      merchant_json = JSON.parse(response.body)
      expect(merchant_json["id"]).to eq(merchant1.id)
    end

    it 'finds a merchant by updated_at' do
      merchant1 = create(:merchant, updated_at: "2015-07-30 12:50:00 UTC")
      merchant2 = create(:merchant)

      get "/api/v1/merchants/find?updated_at=#{merchant1.updated_at}"

      expect(response).to be_successful
      merchant_json = JSON.parse(response.body)
      expect(merchant_json["id"]).to eq(merchant1.id)
    end

    it 'finds all merchants by updated_at' do
      merchant1 = create(:merchant, updated_at: "2015-07-30 12:50:00 UTC")
      merchant2 = create(:merchant, updated_at: "2015-07-30 12:50:00 UTC")
      merchant3 = create(:merchant)

      get "/api/v1/merchants/find_all?updated_at=#{merchant1.updated_at}"

      expect(response).to be_successful
      merchant_json = JSON.parse(response.body)
      expect(merchant_json.first["id"]).to eq(merchant1.id)
      expect(merchant_json.last["id"]).to eq(merchant2.id)
    end

    it 'finds all merchants by created_at' do
      merchant1 = create(:merchant, created_at: "2015-07-30 12:50:00 UTC")
      merchant2 = create(:merchant, created_at: "2015-07-30 12:50:00 UTC")
      merchant3 = create(:merchant)

      get "/api/v1/merchants/find_all?created_at=#{merchant1.created_at}"

      expect(response).to be_successful
      merchant_json = JSON.parse(response.body)
      expect(merchant_json.first["id"]).to eq(merchant1.id)
      expect(merchant_json.last["id"]).to eq(merchant2.id)
    end
  end
end
