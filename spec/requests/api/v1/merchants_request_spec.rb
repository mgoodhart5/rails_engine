require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
  end
  it "can find one merchant by id" do
    id = create(:merchant).id.to_s

    get "/api/v1/merchants/#{id}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["id"]).to eq(id)
  end
  it "can find one merchant by id and specific path" do
    id = create(:merchant).id.to_s

    get "/api/v1/merchants/find?id=#{id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["id"]).to eq(id)
  end
  it "can find one merchants by name and specific path" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"]["attributes"]["name"]).to eq(name)
  end
  it "can find one merchant by name case insensitive" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name.upcase}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end
  it "can find a merchant by created at" do
    merchant_1 = create(:merchant, created_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/merchants/find?created_at=#{merchant_1.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["id"]).to eq(merchant_1.id)
  end
  it "can find a merchant by updated at" do
    merchant_1 = create(:merchant, updated_at: "2012-03-27 14:54:10 UTC")

    get "/api/v1/merchants/find?updated_at=#{merchant_1.updated_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"]["attributes"]["id"]).to eq(merchant_1.id)
  end
  it "can find all merchant by created at" do
    merchant_1 = create(:merchant, created_at: "2012-03-27 14:54:09 UTC")
    merchant_2 = create(:merchant, created_at: "2012-03-27 14:54:09 UTC")
    merchant_3 = create(:merchant, created_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/merchants/find_all?created_at=#{merchant_1.created_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"].count).to eq(2)
  end
  it "can find all merchants by last_name" do
    merchant_1  = create(:merchant, name: "Perez")
    merchant_2  = create(:merchant, name: "Perez")
    merchant_3  = create(:merchant, name: "Smith")

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(2)
  end
  it "can find all merchant by updated at" do
    merchant_1 = create(:merchant, updated_at: "2012-03-27 14:54:09 UTC")
    merchant_2 = create(:merchant, updated_at: "2012-03-27 14:54:09 UTC")
    merchant_3 = create(:merchant, updated_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/merchants/find_all?updated_at=#{merchant_1.updated_at}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body)

    expect(merchant["data"].count).to eq(2)
  end
  it "can call a random resource" do
    create_list(:merchant, 3)

    get "/api/v1/merchants/random.json"

    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random.count).to eq(1)
    expect(random["data"]["type"]).to eq("merchant")
  end
  it 'returns X merchants ranked by total revenue' do

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

    x = 4

    get "/api/v1/merchants/most_revenue?quantity=#{x}"

    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants["data"].count).to eq(x)
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

    x1 = 3

    get "/api/v1/merchants/most_items?quantity=#{x1}"

    merchants = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchants["data"].count).to eq(x1)
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

    x1 = "2012-03-27 14:54:09 UTC"

    get "/api/v1/merchants/revenue?date=#{x1}"

    merchants = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchants["data"]["attributes"]["revenue"]).to eq(Merchant.revenue(x1))
  end
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

    get "/api/v1/merchants/#{m1.id}/revenue"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful

    expect(merchant["data"]["id"]).to eq(m1.name)
  end
  it "returns the favorite customer for a single merchant" do
    m1 = create(:merchant)
    c1 = create(:customer)
    c2 = create(:customer)

    item_1 = create(:item, merchant: m1, unit_price: 400)
    item_2 = create(:item, merchant: m1, unit_price: 300)
    item_3 = create(:item, merchant: m1, unit_price: 500)

    invoice_1 = create(:invoice, merchant: m1, customer: c1)
    invoice_2 = create(:invoice, merchant: m1, customer: c2)
    invoice_3 = create(:invoice, merchant: m1, customer: c2)

    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1500, item_id: item_2.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success", updated_at: "2012-03-27 14:54:09 UTC")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success", updated_at: "2012-03-27 14:54:09 UTC")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success", updated_at: "2012-03-27 14:54:09 UTC")


    get "/api/v1/merchants/#{m1.id}/favorite_customer"

    favorite_cust = JSON.parse(response.body)

    expect(response).to be_successful

    expect(favorite_cust["data"][0]["id"].to_i).to eq(c2.id)
    expect(favorite_cust["data"][0]["id"].to_i).to_not eq(c1.id)
  end
end
