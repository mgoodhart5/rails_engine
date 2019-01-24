class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items
  has_many :customers, through: :invoices

  def self.most_revenue(x)

  end

  def total_revenue
    Merchant.joins(invoices: :invoice_items)
    .select("merchants.*, sum(invoice_items.unit_price) * sum(invoice_items.quantity) as total")
    .where(item_id: "invoice_items.item_id")
    .where(invoice_id: "invoice_items.invoice_id")
    .limit(4)
  end
end
