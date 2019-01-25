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
    money = Merchant.joins(invoices: [:invoice_items, :transactions])
    .where("transactions.result = 0")
    .where("transactions.updated_at = ?", x)
    .sum("invoice_items.unit_price * invoice_items.quantity")
    # (money/100).round(2)
  end

end
