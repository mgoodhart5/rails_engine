require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get "/api/v1/items"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end
  it "can find one item by id" do
    id = create(:item).id.to_s

    get "/api/v1/items/#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(id)
  end
  it "can find one item by id and specific path" do
    id = create(:item).id.to_s

    get "/api/v1/items/find?id=#{id}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["id"]).to eq(id)
  end
  it "can find one items by name and specific path" do
    name = create(:item).name

    get "/api/v1/items/find?name=#{name}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"]["attributes"]["name"]).to eq(name)
  end
  it "can find one item by name case insensitive" do
    name = create(:item).name

    get "/api/v1/items/find?name=#{name.upcase}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["name"]).to eq(name)
  end
  it "can find a item by created at" do
    item_1 = create(:item, created_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/items/find?created_at=#{item_1.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["id"]).to eq(item_1.id)
  end
  it "can find a item by updated at" do
    item_1 = create(:item, updated_at: "2012-03-27 14:54:10 UTC")

    get "/api/v1/items/find?updated_at=#{item_1.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"]["attributes"]["id"]).to eq(item_1.id)
  end
  it "can find all item by created at" do
    item_1 = create(:item, created_at: "2012-03-27 14:54:09 UTC")
    item_2 = create(:item, created_at: "2012-03-27 14:54:09 UTC")
    item_3 = create(:item, created_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/items/find_all?created_at=#{item_1.created_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"].count).to eq(2)
  end
  it "can find all items by name" do
    item_1  = create(:item, name: "Perez")
    item_2  = create(:item, name: "Perez")
    item_3  = create(:item, name: "Smith")

    get "/api/v1/items/find_all?name=#{item_1.name}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(2)
  end
  it "can find all items by merchant_id" do
    m1 = create(:merchant)
    item_1  = create(:item, name: "Perez", merchant: m1)
    item_2  = create(:item, name: "Perez", merchant: m1)
    item_3  = create(:item, name: "Smith", merchant: m1)

    get "/api/v1/items/find_all?merchant=#{m1.id}"

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items["data"].count).to eq(3)
  end
  it "can find all item by updated at" do
    item_1 = create(:item, updated_at: "2012-03-27 14:54:09 UTC")
    item_2 = create(:item, updated_at: "2012-03-27 14:54:09 UTC")
    item_3 = create(:item, updated_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/items/find_all?updated_at=#{item_1.updated_at}"

    expect(response).to be_successful

    item = JSON.parse(response.body)

    expect(item["data"].count).to eq(2)
  end
  it "can call a random resource" do
    create_list(:item, 3)

    get "/api/v1/items/random.json"

    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random.count).to eq(1)
    expect(random["data"]["type"]).to eq("item")
  end
  it "best day" do
    m1, m2 = create_list(:merchant, 2)

    item_1 = create(:item, merchant: m1, unit_price: 400)
    item_2 = create(:item, merchant: m2, unit_price: 300)

    invoice_1 = create(:invoice, merchant: m2, updated_at: "2012-03-25 14:54:09 UTC")
    invoice_2 = create(:invoice, merchant: m1, updated_at: "2012-03-25 14:54:09 UTC")
    invoice_3 = create(:invoice, merchant: m1, updated_at: "2012-03-26 14:54:09 UTC")
    invoice_4 = create(:invoice, merchant: m1, updated_at: "2012-03-26 14:54:09 UTC")

    invoice_item_1 = create(:invoice_item, quantity: 10, unit_price: 1500, item_id: item_2.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 15, unit_price: 500, item_id: item_2.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 20, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)
    invoice_item_4 = create(:invoice_item, quantity: 5, unit_price: 100, item_id: item_1.id, invoice_id: invoice_4.id)

    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
    transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: "success")

    get "/api/v1/items/#{item_1.id}/best_day"

    date = "2012-03-26 14:54:09 UTC"

    item = JSON.parse(response.body)

    expect(response).to be_successful

    expect(item["data"][0]["attributes"]["updated_at"][0..9]).to eq(date[0..9])
    #this is not a cute test
  end
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

    x = 4

    get "/api/v1/items/most_revenue?quantity=#{x}"

    items = JSON.parse(response.body)

    expect(response).to be_successful

    expect(items["data"].count).to eq(x)
  end
  it 'returns the top x items ranked by total number sold' do
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

    x = 3

    get "/api/v1/items/most_items?quantity=#{x}"

    items = JSON.parse(response.body)

    expect(response).to be_successful

    expect(items["data"].count).to eq(x)
  end
end
