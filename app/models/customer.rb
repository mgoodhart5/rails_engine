class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :merchants, through: :invoices

  def favorite_merchant
    Merchant.joins(invoices: :transactions)
    .select("merchants.*, count(transactions.id) as transaction_amount")
    .where(transactions: {result: 0})
    .group("merchants.id")
    .order("transaction_amount desc")
    .where("invoices.customer_id = #{self.id}")
    .limit(1)
    #serialize
  end
end
