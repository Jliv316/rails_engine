require 'rails_helper'

describe 'Customer api' do
  it 'sends a list of all customers' do
    create_list(:customer, 5)

    get '/api/v1/customers.json'

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers.count).to eq(5)
  end

  it 'sends one customer by its id' do
    id = create(:customer).id

    get "/api/v1/customers/#{id}.json"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["id"]).to eq(id)
  end

  describe 'customer finders' do
    it 'finds one customer by id' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/find?id=#{customers[0].id}"

      expect(response).to be_successful

      customers_json = JSON.parse(response.body)

      expect(customers_json["id"]).to eq(customers[0].id)
    end

    it 'finds one customer by first_name' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/find?first_name=#{customers[0].first_name}"

      expect(response).to be_successful

      customers_json = JSON.parse(response.body)

      expect(customers_json["first_name"]).to eq(customers[0].first_name)
    end

    it 'finds one customer by last_name' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/find?last_name=#{customers[0].last_name}"

      expect(response).to be_successful

      customers_json = JSON.parse(response.body)

      expect(customers_json["last_name"]).to eq(customers[0].last_name)
    end

    it 'finds one customer by first_name case insenstive' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/find?first_name=#{customers[0].first_name.upcase}"

      expect(response).to be_successful

      customers_json = JSON.parse(response.body)

      expect(customers_json["first_name"]).to eq(customers[0].first_name)
    end

    it 'finds one customer by last_name case insenstive' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/find?last_name=#{customers[0].last_name.upcase}"

      expect(response).to be_successful

      customers_json = JSON.parse(response.body)

      expect(customers_json["last_name"]).to eq(customers[0].last_name)
    end

    it 'finds all customers by id' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/find_all?id=#{customers[0].id}"

      expect(response).to be_successful
      customers_json = JSON.parse(response.body)
      expect(customers_json.class).to eq(Array)
      expect(customers_json.count).to eq(1)
    end

    it 'finds all customers by first_name' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/find_all?first_name=#{customers[0].first_name}"

      expect(response).to be_successful
      customers_json = JSON.parse(response.body)
      expect(customers_json.count).to eq(1)
    end

    it 'finds all customers by last_name' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/find_all?last_name=#{customers[0].last_name}"

      expect(response).to be_successful
      customers_json = JSON.parse(response.body)
      expect(customers_json.count).to eq(1)
    end

    it 'finds a random customer' do
      customers = create_list(:customer, 5)

      get "/api/v1/customers/random.json"

      expect(response).to be_successful
      random_customer = JSON.parse(response.body)
      expect(customers.map{ |customer| customer.first_name.include?(random_customer["first_name"])}).to be_truthy
      expect(customers.map{ |customer| customer.last_name.include?(random_customer["last_name"])}).to be_truthy
    end

    it 'finds a customer by created_at' do
      customer1 = create(:customer, created_at: "2015-07-30 12:50:00 UTC")
      customer2 = create(:customer)

      get "/api/v1/customers/find?created_at=#{customer1.created_at}"

      expect(response).to be_successful
      customer_json = JSON.parse(response.body)
      expect(customer_json["id"]).to eq(customer1.id)
    end

    it 'finds a customer by updated_at' do
      customer1 = create(:customer, updated_at: "2015-07-30 12:50:00 UTC")
      customer2 = create(:customer)

      get "/api/v1/customers/find?updated_at=#{customer1.updated_at}"

      expect(response).to be_successful
      customer_json = JSON.parse(response.body)
      expect(customer_json["id"]).to eq(customer1.id)
    end

    it 'finds all customers by updated_at' do
      customer1 = create(:customer, updated_at: "2015-07-30 12:50:00 UTC")
      customer2 = create(:customer, updated_at: "2015-07-30 12:50:00 UTC")
      customer3 = create(:customer)

      get "/api/v1/customers/find_all?updated_at=#{customer1.updated_at}"

      expect(response).to be_successful
      customer_json = JSON.parse(response.body)
      expect(customer_json.first["id"]).to eq(customer1.id)
      expect(customer_json.last["id"]).to eq(customer2.id)
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
