class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.revenue_by_quantity(limit)
    select("items.*, sum(invoice_items.unit_price*invoice_items.quantity) AS revenue")
    .joins(:invoice_items)
    .group(:id)
    .order("revenue DESC")
    .limit(limit)
  end

  def self.most_sold(limit)
    select("items.*, sum(invoice_items.quantity) AS quantity")
    .joins(invoices: [:transactions])
    .where(transactions: {result: "success"})
    .group(:id).order("quantity DESC")
    .limit(limit)
  end
end
