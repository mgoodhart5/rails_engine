require 'rails_helper'

describe "Invoice_items API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end
  it "can find one invoice_item by id" do
    id = create(:invoice_item).id.to_s

    get "/api/v1/invoice_items/#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(id)
  end
  it "can find one invoice_item by id and specific path" do
    id = create(:invoice_item).id.to_s

    get "/api/v1/invoice_items/find?id=#{id}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["id"]).to eq(id)
  end
  it "can find one invoice_items by name and specific path" do
    name = create(:invoice_item).name

    get "/api/v1/invoice_items/find?name=#{name}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"]["attributes"]["name"]).to eq(name)
  end
  it "can find one invoice_item by name case insensitive" do
    name = create(:invoice_item).name

    get "/api/v1/invoice_items/find?name=#{name.upcase}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["attributes"]["name"]).to eq(name)
  end
  it "can find a invoice_item by created at" do
    invoice_item_1 = create(:invoice_item, created_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_1.id)
  end
  it "can find a invoice_item by updated at" do
    invoice_item_1 = create(:invoice_item, updated_at: "2012-03-27 14:54:10 UTC")

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item_1.updated_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"]["attributes"]["id"]).to eq(invoice_item_1.id)
  end
  it "can find all invoice_item by created at" do
    invoice_item_1 = create(:invoice_item, created_at: "2012-03-27 14:54:09 UTC")
    invoice_item_2 = create(:invoice_item, created_at: "2012-03-27 14:54:09 UTC")
    invoice_item_3 = create(:invoice_item, created_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/invoice_items/find_all?created_at=#{invoice_item_1.created_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"].count).to eq(2)
  end
  it "can find all invoice_items by name" do
    invoice_item_1  = create(:invoice_item, name: "Perez")
    invoice_item_2  = create(:invoice_item, name: "Perez")
    invoice_item_3  = create(:invoice_item, name: "Smith")

    get "/api/v1/invoice_items/find_all?name=#{invoice_item_1.name}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(2)
  end
  it "can find all invoice_items by merchant_id" do
    m1 = create(:merchant)
    invoice_item_1  = create(:invoice_item, name: "Perez", merchant: m1)
    invoice_item_2  = create(:invoice_item, name: "Perez", merchant: m1)
    invoice_item_3  = create(:invoice_item, name: "Smith", merchant: m1)

    get "/api/v1/invoice_items/find_all?merchant=#{m1.id}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(3)
  end
  it "can find all invoice_item by updated at" do
    invoice_item_1 = create(:invoice_item, updated_at: "2012-03-27 14:54:09 UTC")
    invoice_item_2 = create(:invoice_item, updated_at: "2012-03-27 14:54:09 UTC")
    invoice_item_3 = create(:invoice_item, updated_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/invoice_items/find_all?updated_at=#{invoice_item_1.updated_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"].count).to eq(2)
  end
  it "can call a random resource" do
    create_list(:invoice_item, 3)

    get "/api/v1/invoice_items/random.json"

    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random.count).to eq(1)
    expect(random["data"]["type"]).to eq("invoice_item")
  end
end
