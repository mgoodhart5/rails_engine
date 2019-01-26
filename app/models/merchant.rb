class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.most_revenue(x)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .where("transactions.result = 0")
    .order("revenue desc")
    .limit(x)
  end

  def self.most_items(x)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, sum(invoice_items.quantity) as most_items")
    .group(:id)
    .where("transactions.result = 0")
    .order("most_items desc")
    .limit(x)
  end

  def self.revenue(x)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = 0")
    .where("transactions.updated_at = ?", x)
    .sum("invoice_items.unit_price * invoice_items.quantity")
    # (money/100).round(2)
  end

  def total_revenue
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0}, merchants: {id: self.id})
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def revenue_by_date(x)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 0}, merchants: {id: self.id})
    .where("invoices.updated_at = ?", x)
    .sum("invoice_items.unit_price * invoice_items.quantity")
    #serialize
  end

  def favorite_customer
    total = Customer.joins(merchants: [invoices: :transactions])
    .where(transactions: {result: 0}, merchants: {id: self.id})
    .group("customers.id")
    .limit(1)
    # binding.pry
    # SELECT in here since it's based on amount of successful transactions
    #returning as an array, does this work with serializing?
    #serialize
  end

end
