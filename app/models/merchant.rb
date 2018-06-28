class Merchant < ApplicationRecord
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices
  has_many :invoice_items, through: :invoices

  def single_merchant_revenue
    invoices
          .select("sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
          .joins(:invoice_items, :transactions)
          .where(transactions: {result: "success"})[0].revenue
  end
end
