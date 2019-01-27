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
    expect(items["data"][0]["type"]).to eq("associated_item")
  end
  it 'returns a collection of invoices associated with that merchant' do
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

    expect(invoices["data"][0]["type"]).to eq("associated_invoice")
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

    expect(invoices["data"][0]["type"]).to eq("associated_invoice_item")
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
  it 'returns a customer associated with that invoice' do
    m1, m2 = create_list(:merchant, 2)

    c1 = create(:customer)
    c2 = create(:customer)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c2)


    get "/api/v1/invoices/#{invoice_1.id}/customer"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoices["data"]["id"].to_i).to eq(c1.id)
  end
  it 'returns the merchant associated with that invoice' do
    m1, m2 = create_list(:merchant, 2)

    c1 = create(:customer)
    c2 = create(:customer)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m2, customer: c2)


    get "/api/v1/invoices/#{invoice_1.id}/merchant"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoices["data"]["id"].to_i).to eq(m1.id)
    expect(invoices["data"]["id"].to_i).to_not eq(m2.id)
  end
  it 'returns an invoice associated with that invoice_item' do
    m1, m2 = create_list(:merchant, 2)

    c1 = create(:customer)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c1)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m1)
    item_3 = create(:item, merchant: m2)

    invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 1500, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 4, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)

    transaction = create(:transaction, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_1)


    get "/api/v1/invoice_items/#{invoice_item_1.id}/invoice"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoices["data"]["id"].to_i).to eq(invoice_1.id)
  end
  it 'returns an item associated with that invoice_item' do
    m1, m2 = create_list(:merchant, 2)

    c1 = create(:customer)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c1)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m1)
    item_3 = create(:item, merchant: m2)

    invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 1500, item_id: item_3.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 4, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)

    transaction = create(:transaction, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_1)


    get "/api/v1/invoice_items/#{invoice_item_1.id}/item"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoices["data"]["id"].to_i).to eq(item_3.id)
  end
  it 'returns a collection of invoice items associated with that item' do
    m1, m2 = create_list(:merchant, 2)

    c1 = create(:customer)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c1)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m1)
    item_3 = create(:item, merchant: m2)

    invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 1500, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 4, unit_price: 500, item_id: item_1.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_2.id, invoice_id: invoice_1.id)
    invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_1.id)

    transaction = create(:transaction, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_1)

    get "/api/v1/items/#{item_1.id}/invoice_items"

    invoices = JSON.parse(response.body)

    x = 3

    expect(response).to be_successful

    expect(invoices["data"].count).to eq(x)
    expect(invoices["data"][0]["type"]).to eq("associated_invoice_item")
  end
  it 'item returns the merchant associated with that invoice' do
    m1, m2 = create_list(:merchant, 2)

    c1 = create(:customer)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c1)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m1)
    item_3 = create(:item, merchant: m2)


    get "/api/v1/items/#{item_1.id}/merchant"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoices["data"]["id"].to_i).to eq(m1.id)
  end
  it 'returns an invoice associated with a since transaction' do
    m1, m2 = create_list(:merchant, 2)

    c1 = create(:customer)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c1)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m1)
    item_3 = create(:item, merchant: m2)

    invoice_item_1 = create(:invoice_item, quantity: 5, unit_price: 1500, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 4, unit_price: 500, item_id: item_1.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_2.id, invoice_id: invoice_1.id)
    invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_1.id)

    transaction = create(:transaction, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_1)
    transaction_3 = create(:transaction, invoice: invoice_1)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful

    expect(invoices["data"]["id"].to_i).to eq(invoice_2.id)
    expect(invoices["data"]["type"]).to eq("associated_invoice")
  end
  it 'returns a collection of invoices associated with that customer' do
    m1, m2 = create_list(:merchant, 2)
    c1 = create(:customer)
    c2 = create(:customer)

    item_1 = create(:item, merchant: m1)
    item_2 = create(:item, merchant: m1)
    item_3 = create(:item, merchant: m2)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c1)
    invoice_3 = create(:invoice, merchant: m2, customer: c2)

    get "/api/v1/customers/#{c1.id}/invoices"

    invoices = JSON.parse(response.body)

    x = 2

    expect(response).to be_successful

    expect(invoices["data"].count).to eq(x)

    expect(invoices["data"][0]["type"]).to eq("associated_invoice")
  end
end
