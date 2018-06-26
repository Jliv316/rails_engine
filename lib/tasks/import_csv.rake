require 'csv'

namespace :import do
  desc:"All CSV data"
  task all: [:merchants, :customers, :invoices, :items, :invoice_items, :transactions]

  desc:"Create merchants"
  task :merchants, [:merchants] => :environment do
    CSV.foreach('data/merchants.csv', :headers => true) do |row|
      Merchant.find_or_create_by(row.to_hash)
    end
  end

  desc:"Create customers"
  task :customers, [:customers] => :environment do
    CSV.foreach('data/customers.csv', :headers => true) do |row|
      Customer.find_or_create_by(row.to_hash)
    end
  end

  desc:"Create invoices"
  task :invoices, [:invoices] => :environment do
    CSV.foreach('data/invoices.csv', :headers => true) do |row|
      Invoice.find_or_create_by(row.to_hash)
    end
  end

  desc:"Create items"
  task :items, [:items] => :environment do
    CSV.foreach('data/items.csv', :headers => true) do |row|
      Item.find_or_create_by(row.to_hash)
    end
  end

  desc:"Create invoice_items"
  task :invoice_items, [:invoice_items] => :environment do
    CSV.foreach('data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.find_or_create_by(row.to_hash)
    end
  end

  desc:"Create transactions"
  task :transactions, [:transactions] => :environment do
    CSV.foreach('data/transactions.csv', :headers => true) do |row|
      Transaction.find_or_create_by(row.to_hash)
    end
  end
end
