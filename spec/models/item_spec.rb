require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should belong_to(:merchant)}
  end
  describe 'Class Methods' do
    it '.most_revenue' do
      m1, m2, m3, m4, m5 = create_list(:merchant, 5)

      item_1 = create(:item, merchant: m1, unit_price: 400)
      item_2 = create(:item, merchant: m2, unit_price: 50)
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

      answer = Item.most_revenue(data)

      expect(answer[0]).to eq(item_5)
      expect(answer[1]).to eq(item_3)
      expect(answer[2]).to eq(item_1)
      expect(answer[3]).to eq(item_4)
    end
  end
  it 'calculates total items sold for X items' do
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
    invoice_item_4 = create(:invoice_item, quantity: 5, unit_price: 100, item_id: item_1.id, invoice_id: invoice_4.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
    transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: "success")

    amount = 3

    answer = Item.most_items(amount)

    expect(answer[0]).to eq(item_1)
    expect(answer[1]).to eq(item_3)
    expect(answer[2]).to eq(item_5)
  end
  # it "best day" do
  #
  # end
end
