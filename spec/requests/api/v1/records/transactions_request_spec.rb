require 'rails_helper'

describe 'Transaction Api' do

  it 'sends a list of all transactions' do
    create_list(:transaction, 5)
    get '/api/v1/transactions.json'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(5)
  end

  it 'sends one transaction by its id' do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}.json"

    transaction = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transaction["id"]).to eq(id)
  end

  describe 'transaction finders' do
    it 'finds one transaction by id' do
      transactions = create_list(:transaction, 5)

      get "/api/v1/transactions/find?id=#{transactions[0].id}"

      expect(response).to be_successful

      transactions_json = JSON.parse(response.body)

      expect(transactions_json["id"]).to eq(transactions[0].id)
    end

    it 'finds one transaction by result' do
      transactions = create_list(:transaction, 5)

      get "/api/v1/transactions/find?result=#{transactions[0].result}"

      expect(response).to be_successful

      transactions_json = JSON.parse(response.body)

      expect(transactions_json["result"]).to eq(transactions[0].result)
    end


    it 'finds one transaction by result case insenstive' do
      transactions = create_list(:transaction, 5)

      get "/api/v1/transactions/find?result=#{transactions[0].result.upcase}"

      expect(response).to be_successful

      transactions_json = JSON.parse(response.body)

      expect(transactions_json["result"]).to eq(transactions[0].result)
    end

    it 'finds one transaction by invoice_id' do
      transactions = create_list(:transaction, 5)

      get "/api/v1/transactions/find?invoice_id=#{transactions[0].invoice_id}"

      expect(response).to be_successful

      transactions_json = JSON.parse(response.body)

      expect(transactions_json["invoice_id"]).to eq(transactions[0].invoice_id)
    end

    it 'finds one transaction by credit_card_number' do
      transactions = create_list(:transaction, 5)

      get "/api/v1/transactions/find?credit_card_number=#{transactions[0].credit_card_number}"

      expect(response).to be_successful

      transactions_json = JSON.parse(response.body)

      expect(transactions_json["credit_card_number"]).to eq(transactions[0].credit_card_number.to_s)
    end

    it 'finds all transactions by id' do
      transactions = create_list(:transaction, 5)

      get "/api/v1/transactions/find_all?id=#{transactions[0].id}"

      expect(response).to be_successful
      transactions_json = JSON.parse(response.body)
      expect(transactions_json.class).to eq(Array)
      expect(transactions_json.count).to eq(1)
    end

    it 'finds all transactions by result' do
      transaction1 = create(:transaction, result: 'success')
      transaction2 = create(:transaction, result: 'success')
      transaction3 = create(:transaction, result: 'failed')
      transaction4 = create(:transaction, result: 'success')

      get "/api/v1/transactions/find_all?result=#{transaction1.result}"

      expect(response).to be_successful
      transactions_json = JSON.parse(response.body)
      expect(transactions_json.count).to eq(3)
    end

    it 'finds a random transaction' do
      transactions = create_list(:transaction, 5)

      get "/api/v1/transactions/random.json"

      expect(response).to be_successful
      random_transaction = JSON.parse(response.body)
      expect(transactions.map(&:id).include?(random_transaction["id"])).to be_truthy
    end

    it 'finds a transaction by created_at' do
      transaction1 = create(:transaction, created_at: "2015-07-30 12:50:00 UTC")
      transaction2 = create(:transaction)

      get "/api/v1/transactions/find?created_at=#{transaction1.created_at}"

      expect(response).to be_successful
      transaction_json = JSON.parse(response.body)
      expect(transaction_json["id"]).to eq(transaction1.id)
    end

    it 'finds a transaction by updated_at' do
      transaction1 = create(:transaction, updated_at: "2015-07-30 12:50:00 UTC")
      transaction2 = create(:transaction)

      get "/api/v1/transactions/find?updated_at=#{transaction1.updated_at}"

      expect(response).to be_successful
      transaction_json = JSON.parse(response.body)
      expect(transaction_json["id"]).to eq(transaction1.id)
    end

    it 'finds all transactions by updated_at' do
      transaction1 = create(:transaction, updated_at: "2015-07-30 12:50:00 UTC")
      transaction2 = create(:transaction, updated_at: "2015-07-30 12:50:00 UTC")
      transaction3 = create(:transaction)

      get "/api/v1/transactions/find_all?updated_at=#{transaction1.updated_at}"

      expect(response).to be_successful
      transaction_json = JSON.parse(response.body)
      expect(transaction_json.first["id"]).to eq(transaction1.id)
      expect(transaction_json.last["id"]).to eq(transaction2.id)
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
