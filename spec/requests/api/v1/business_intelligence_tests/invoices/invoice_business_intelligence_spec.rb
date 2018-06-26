require 'rails_helper'

context 'get request to /api/v1/invoices/id' do
    xit 'can get one invoice by id' do
      id = create(:invoice).id

      get "/api/v1/merchants/1/customers_with_pending_invoices"

      expect(response).to be_successful
    end
  end