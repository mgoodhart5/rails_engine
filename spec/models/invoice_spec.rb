require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Validations' do
    it {should belong_to(:merchant)}
    it {should belong_to(:customer)}
    it {should have_many(:invoice_items)}
    it {should have_many(:items).through(:invoice_items)}
  end
  describe '#all_items' do
    it 'all_items' do
      m1, m2 = create_list(:merchant, 2)

      c1 = create(:customer)

      invoice_1 = create(:invoice, merchant: m1, customer: c1)
      invoice_2 = create(:invoice, merchant: m1, customer: c1)

      item_1 = create(:item, merchant: m1)
      item_2 = create(:item, merchant: m1)
      item_3 = create(:item, merchant: m2)

      invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 1500, item_id: item_1.id, invoice_id: invoice_1.id)
      invoice_item_2 = create(:invoice_item, quantity: 4, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_2.id, invoice_id: invoice_1.id)

      transaction = create(:transaction, invoice: invoice_2)
      transaction_2 = create(:transaction, invoice: invoice_1)
      transaction_3 = create(:transaction, invoice: invoice_1)

      expect(invoice_1.all_items.count).to eq(3)
    end
  end
end
