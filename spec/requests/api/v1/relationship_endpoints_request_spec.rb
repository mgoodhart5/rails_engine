require 'rails_helper'

describe 'merchants nested API' do
  it 'returns a collection of items associated with that merchant' do
    m1, m2 = create_list(:merchant, 2)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m2)
    item_3 = create(:item, merchant: m2)
    item_4 = create(:item, merchant: m1)
    item_5 = create(:item, merchant: m1)

    get "/api/v1/merchants/#{m1.id}/items"

    items = JSON.parse(response.body)

    x = 3

    expect(response).to be_successful

    expect(items["data"].count).to eq(x)
    expect(items["data"][0]["attributes"]["merchant_id"].to_i).to eq(m1.id)
  end
  it 'returns a collection of items associated with that merchant' do
    m1, m2 = create_list(:merchant, 2)
    c1 = create(:customer)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m1)
    item_3 = create(:item, merchant: m2)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c1)
    invoice_3 = create(:invoice, merchant: m2, customer: c1)

    get "/api/v1/merchants/#{m1.id}/invoices"

    invoices = JSON.parse(response.body)

    x = 2

    expect(response).to be_successful

    expect(invoices["data"].count).to eq(x)
    expect(invoices["data"][0]["attributes"]["merchant_id"].to_i).to eq(m1.id)
  end
  it 'returns a collection of transactions associated with that invoice' do
    m1, m2 = create_list(:merchant, 2)
    c1 = create(:customer)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c1)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m1)
    item_3 = create(:item, merchant: m2)

    transaction = create(:transaction, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_1)


    get "/api/v1/invoices/#{invoice_1.id}/transactions"

    invoices = JSON.parse(response.body)

    x = 2

    expect(response).to be_successful

    expect(invoices["data"].count).to eq(x)

    expect(invoices["data"][0]["type"]).to eq("associated_transaction")
  end
  it 'returns a collection of invoice_items associated with that invoice' do
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

    transaction = create(:transaction, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_1)


    get "/api/v1/invoices/#{invoice_1.id}/invoice_items"

    invoices = JSON.parse(response.body)

    x = 2

    expect(response).to be_successful

    expect(invoices["data"].count).to eq(x)

    expect(invoices["data"][0]["type"]).to eq("associated_invoice_items")
  end
  it 'returns a collection of items associated with that invoice' do
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

    transaction = create(:transaction, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_1)

    get "/api/v1/invoices/#{invoice_1.id}/items"

    invoices = JSON.parse(response.body)

    x = 2

    expect(response).to be_successful

    expect(invoices["data"].count).to eq(x)
  end
end
