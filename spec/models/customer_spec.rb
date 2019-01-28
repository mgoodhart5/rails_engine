require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should have_many(:invoices)}
    it {should have_many(:merchants).through(:invoices)}
  end
  describe 'instance_methods' do

    it 'returns fav merchant with most successful transactions' do
      customer = create(:customer)
      m1 = create(:merchant)
      m2 = create(:merchant)

      item_1 = create(:item, merchant: m2, unit_price: 400)
      item_2 = create(:item, merchant: m1, unit_price: 300)
      item_3 = create(:item, merchant: m1, unit_price: 500)

      invoice_1 = create(:invoice, customer: customer, merchant: m2)
      invoice_2 = create(:invoice, customer: customer, merchant: m1)
      invoice_3 = create(:invoice, customer: customer, merchant: m1)

      invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1500, item_id: item_2.id, invoice_id: invoice_1.id)
      invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
      invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)


      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")

      fav = m1
      # binding.pry
      expect(customer.favorite_merchant[0]).to eq(fav)
      expect(customer.favorite_merchant[0]).to_not eq(m2)
    end
    it '#all_transactions' do
      m1, m2 = create_list(:merchant, 2)
      c1 = create(:customer)
      c2 = create(:customer)

      item_1 = create(:item, merchant: m1)
      item_2 = create(:item, merchant: m1)
      item_3 = create(:item, merchant: m2)

      invoice_1 = create(:invoice, merchant: m1, customer: c1)
      invoice_3 = create(:invoice, merchant: m2, customer: c2)

      transaction = create(:transaction, invoice: invoice_3)
      transaction_2 = create(:transaction, invoice: invoice_1)
      transaction_3 = create(:transaction, invoice: invoice_1)

      expect(c1.all_transactions.count).to eq(2)
      expect(c1.all_transactions).to eq([transaction_2, transaction_3])
    end
  end
end
