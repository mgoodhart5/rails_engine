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

      data = 4

      answer = Merchant.most_revenue(data)

      expect(answer.count).to eq(data)
      expect(answer[0]).to eq(m5)
      expect(answer[1]).to eq(m3)
      expect(answer[2]).to eq(m1)
      expect(answer[3]).to eq(m4)
    end
  end
  describe 'instance_methods' do
    it '#total_revenue' do
      m1 = create(:merchant)
      item_1 = create(:item, merchant: m1, unit_price: 400)
      invoice_1 = create(:invoice, merchant: m1)
      invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 20, item_id: item_1.id, invoice_id: invoice_1.id)
      transaction = create(:transaction, invoice_id: invoice_1.id)

      expect(m1.total_revenue).to eq(100)
    end
  end
end
