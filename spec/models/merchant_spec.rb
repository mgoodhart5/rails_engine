require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should have_many(:invoices)}
    it {should have_many(:items)}
    it {should have_many(:customers).through(:invoices)}
  end
  describe 'Class Methods' do
    it '.most_revenue' do
      m1, m2, m3, m4, m5 = create_list(:merchant, 5)

      item_1 = create(:item, merchant: m1, unit_price: 400)
      item_2 = create(:item, merchant: m2)
      item_3 = create(:item, merchant: m3, unit_price: 500)
      item_4 = create(:item, merchant: m4, unit_price: 100)
      item_5 = create(:item, merchant: m5, unit_price: 1500)

      invoice_1 = create(:invoice, merchant: m5)
      invoice_2 = create(:invoice, merchant: m3)
      invoice_3 = create(:invoice, merchant: m1)
      invoice_4 = create(:invoice, merchant: m4)
      invoice_5 = create(:invoice, merchant: m2)

      invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 1500, item_id: item_5.id, invoice_id: invoice_1.id)
      invoice_item_1 = create(:invoice_item, quantity: 4, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_1 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)
      invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 100, item_id: item_4.id, invoice_id: invoice_4.id)

      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
      transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: "success")

      data = 4

      answer = Merchant.most_revenue(data)

      expect(answer[0]).to eq(m5)
      expect(answer[1]).to eq(m3)
      expect(answer[2]).to eq(m1)
      expect(answer[3]).to eq(m4)
    end
  end
  it 'calculates total items sold for X merchants' do
    m1, m2, m3, m4, m5 = create_list(:merchant, 5)

    item_1 = create(:item, merchant: m1, unit_price: 400)
    item_2 = create(:item, merchant: m2, unit_price: 300)
    item_3 = create(:item, merchant: m3, unit_price: 500)
    item_4 = create(:item, merchant: m4, unit_price: 100)
    item_5 = create(:item, merchant: m5, unit_price: 1500)

    invoice_1 = create(:invoice, merchant: m5)
    invoice_2 = create(:invoice, merchant: m3)
    invoice_3 = create(:invoice, merchant: m1)
    invoice_4 = create(:invoice, merchant: m4)
    invoice_5 = create(:invoice, merchant: m2)

    invoice_item_1 = create(:invoice_item, quantity: 10, unit_price: 1500, item_id: item_5.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 15, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 20, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)
    invoice_item_4 = create(:invoice_item, quantity: 5, unit_price: 100, item_id: item_4.id, invoice_id: invoice_4.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
    transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: "success")

    x = 3

    answer = Merchant.most_items(x)

    expect(answer[0]).to eq(m1)
    expect(answer[1]).to eq(m3)
    expect(answer[2]).to eq(m5)
  end
  it 'returns total merchants who sold on X date' do
    m1, m2, m3, m4, m5 = create_list(:merchant, 5)

    item_1 = create(:item, merchant: m1, unit_price: 400)
    item_2 = create(:item, merchant: m2, unit_price: 300)
    item_3 = create(:item, merchant: m3, unit_price: 500)
    item_4 = create(:item, merchant: m4, unit_price: 100)
    item_5 = create(:item, merchant: m5, unit_price: 1500)

    invoice_1 = create(:invoice, merchant: m5)
    invoice_2 = create(:invoice, merchant: m3)
    invoice_3 = create(:invoice, merchant: m1)
    invoice_4 = create(:invoice, merchant: m4)
    invoice_5 = create(:invoice, merchant: m2)

    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1500, item_id: item_5.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)
    invoice_item_4 = create(:invoice_item, quantity: 5, unit_price: 100, item_id: item_4.id, invoice_id: invoice_4.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", updated_at: "2012-03-27 14:54:09 UTC")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success", updated_at: "2012-03-27 14:54:09 UTC")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success", updated_at: "2012-03-27 14:54:09 UTC")
    transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: "success", updated_at: "2012-03-25 14:54:09 UTC")

    x = "2012-03-27 14:54:09 UTC"

    answer_rev = Merchant.revenue(x)
    total = 3700

    expect(answer_rev).to eq(total)
  end
  describe 'instance methods'do
    it "returns the total revenue for a single merchant successful transaction" do
      m1 = create(:merchant)

      item_1 = create(:item, merchant: m1, unit_price: 400)
      item_2 = create(:item, merchant: m1, unit_price: 300)
      item_3 = create(:item, merchant: m1, unit_price: 500)

      invoice_1 = create(:invoice, merchant: m1)
      invoice_2 = create(:invoice, merchant: m1)
      invoice_3 = create(:invoice, merchant: m1)

      invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1500, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)

      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", updated_at: "2012-03-27 14:54:09 UTC")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success", updated_at: "2012-03-27 14:54:09 UTC")
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "failed", updated_at: "2012-03-27 14:54:09 UTC")

      total_rev = 2500

      expect(m1.total_revenue).to eq(total_rev)
    end
  end
end
