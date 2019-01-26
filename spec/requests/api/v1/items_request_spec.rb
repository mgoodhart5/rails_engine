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
end
