class Merchant < ApplicationRecord
  validates_uniqueness_of :name, :case_sensitive => false

  has_many :invoices
  has_many :items
end
