class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def single_merchant_revenue
    invoices
          .select("sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
          .joins(:invoice_items, :transactions)
          .where(transactions: {result: "success"})[0].revenue
  end

  def merchant_revenue_by_date(date)
    invoices
          .select("sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
          .joins(:invoice_items, :transactions)
          .where(transactions: {result: "success"}, created_at: date.beginning_of_day..date.end_of_day)[0]
          .revenue
  end

  def self.merchants_revenue_by_date(date)
    Invoice
          .select("sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
          .joins(:invoice_items, :transactions)
          .where(transactions: {result: "success"}, created_at: date.beginning_of_day..date.end_of_day)[0]
          .revenue
  end

  def self.most_items(quantity)
    joins(:invoices, :transactions,:invoice_items)
    .order("sum(invoice_items.quantity) DESC")
    .group(:id)
    .where( transactions: {result: "success"})
    .limit(quantity)
  end

  def fav_customer
    customers.joins(:invoices, :transactions)
    .order("transactions.count DESC")
    .where(transactions: {result: "success"})
    .group(:id)
    .limit(1).first
  end
end
