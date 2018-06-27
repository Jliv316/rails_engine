class Merchant < ApplicationRecord
  validates_uniqueness_of :name

  has_many :invoices
  has_many :items
end
