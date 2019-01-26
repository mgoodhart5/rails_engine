require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
    it {should have_many(:invoices)}
    it {should have_many(:merchants).through(:invoices)}
  end
  it 'returns fav customer with most successful transactions' do
    customer = create(:customer)
    m1 = create(:merchant)
    m2 = create(:merchant)

    item_1 = create(:item, merchant: m2, unit_price: 400)
    item_2 = create(:item, merchant: m2, unit_price: 300)
    item_3 = create(:item, merchant: m1, unit_price: 500)

    invoice_1 = create(:invoice, customer: customer, merchant: m2)
    invoice_2 = create(:invoice, customer: customer, merchant: m2)
    invoice_3 = create(:invoice, customer: customer, merchant: m1)

    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1500, item_id: item_2.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)


    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")

    fav = m2

    expect(customer.favorite_merchant).to eq([fav])
  end
end
