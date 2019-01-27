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
  it "can find one invoice_items by quantity and specific path" do
    quantity = create(:invoice_item).quantity

    get "/api/v1/invoice_items/find?quantity=#{quantity}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"][0]["attributes"]["quantity"]).to eq(quantity)
  end
  it "can find a invoice_item by created at" do
    invoice_item_1 = create(:invoice_item, created_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/invoice_items/find?created_at=#{invoice_item_1.created_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"][0]["id"].to_i).to eq(invoice_item_1.id)
  end
  it "can find a invoice_item by updated at" do
    invoice_item_1 = create(:invoice_item, updated_at: "2012-03-27 14:54:10 UTC")

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item_1.updated_at}"

    expect(response).to be_successful

    invoice_item = JSON.parse(response.body)

    expect(invoice_item["data"][0]["id"].to_i).to eq(invoice_item_1.id)
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
  it "can find all invoice_items by quantity" do
    invoice_item_1  = create(:invoice_item, quantity: 5)
    invoice_item_2  = create(:invoice_item, quantity: 5)
    invoice_item_3  = create(:invoice_item, quantity: 7)

    get "/api/v1/invoice_items/find_all?quantity=#{invoice_item_1.quantity}"

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items["data"].count).to eq(2)
  end
  it "can find all invoice_items by item_id" do
    i_1, i_2 = create_list(:item, 2)
    # binding.pry
    invoice_item_1  = create(:invoice_item, item: i_1)
    invoice_item_2  = create(:invoice_item, item: i_1)
    invoice_item_3  = create(:invoice_item, item: i_1)
    invoice_item_4  = create(:invoice_item, item: i_2)

    get "/api/v1/invoice_items/find_all?item=#{i_1.id}"

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
