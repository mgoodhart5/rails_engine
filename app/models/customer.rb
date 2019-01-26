class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    Merchant.joins(customers: [invoices: :transactions])
    .where(transactions: {result: 0}, customers: {id: self.id})
    .group("merchants.id")
    .order("merchants.id desc")
    .limit(1)
    # .select("merchants.*, sum(invoice_items.quantity) as most_items")
    #ascending/desc
    #returning as an array, does this work with serializing?
    #serialize
  end
end
