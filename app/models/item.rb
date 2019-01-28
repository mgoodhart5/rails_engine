class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue(x)
    Item.joins(invoices: [:invoice_items, :transactions])
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .where("transactions.result = 0")
    .order("revenue desc")
    .limit(x)

  end

  def self.most_items(x)
    Item.joins(invoices: [:invoice_items, :transactions])
    .select("items.*, sum(invoice_items.quantity) as most_items")
    .group(:id)
    .where("transactions.result = 0")
    .order("most_items desc")
    .limit(x)
  end

  def best_day
    Invoice.joins(:invoice_items, :transactions)
    .select("invoices.*, count(invoices.id) as invoice_amount")
    .where(transactions: {result: 0})
    .where("invoice_items.item_id = #{self.id}")
    .group("invoices.id")
    .order("invoice_amount desc")
  end

end
