class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def fav_merchant
    merchants
    .joins(:invoices, :transactions)
    .order("transactions.count DESC")
    .where(transactions: {result: "success"})
    .group(:id)
    .limit(1)
    .first
  end
end
