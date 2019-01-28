require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    create_list(:invoice, 3)

    get "/api/v1/invoices"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end
  it "can find one invoice by id" do
    id = create(:invoice).id.to_s

    get "/api/v1/invoices/#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"]).to eq(id)
  end
  it "can find one invoice by id and specific path" do
    id = create(:invoice).id.to_s

    get "/api/v1/invoices/find?id=#{id}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"]).to eq(id)
  end
  it "can find invoices by status and specific path" do
    status = create(:invoice).status

    get "/api/v1/invoices/find_all?status=#{status}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"][0]["attributes"]["status"]).to eq(status)
  end
  it "can find invoices by status case insensitive" do
    status = create(:invoice).status

    get "/api/v1/invoices/find_all?status=#{status}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"][0]["attributes"]["status"]).to eq(status)
  end
  it "can find an invoice by created at" do
    invoice_1 = create(:invoice, created_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/invoices/find?created_at=#{invoice_1.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(invoice_1.id)
  end
  it "can find an invoice by updated at" do
    invoice_1 = create(:invoice, updated_at: "2012-03-27 14:54:10 UTC")

    get "/api/v1/invoices/find?updated_at=#{invoice_1.updated_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"]["id"].to_i).to eq(invoice_1.id)
  end
  it "can find all invoice by created at" do
    invoice_1 = create(:invoice, created_at: "2012-03-27 14:54:09 UTC")
    invoice_2 = create(:invoice, created_at: "2012-03-27 14:54:09 UTC")
    invoice_3 = create(:invoice, created_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/invoices/find_all?created_at=#{invoice_1.created_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"].count).to eq(2)
  end
  it "can find all invoices by merchant_id" do
    m1 = create(:merchant)
    invoice_1  = create(:invoice, merchant: m1)
    invoice_2  = create(:invoice, merchant: m1)
    invoice_3  = create(:invoice, merchant: m1)

    get "/api/v1/invoices/find_all?merchant_id=#{m1.id}"

    expect(status).to eq(200)

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end
  it "can find all invoices by item_id" do
    m1 = create(:merchant)
    invoice_1  = create(:invoice, merchant: m1)
    invoice_2  = create(:invoice, merchant: m1)
    invoice_3  = create(:invoice, merchant: m1)

    get "/api/v1/invoices/find_all?merchant_id=#{m1.id}"

    expect(response).to be_successful

    invoices = JSON.parse(response.body)

    expect(invoices["data"].count).to eq(3)
  end
  it "can find all invoice by updated at" do
    invoice_1 = create(:invoice, updated_at: "2012-03-27 14:54:09 UTC")
    invoice_2 = create(:invoice, updated_at: "2012-03-27 14:54:09 UTC")
    invoice_3 = create(:invoice, updated_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/invoices/find_all?updated_at=#{invoice_1.updated_at}"

    expect(response).to be_successful

    invoice = JSON.parse(response.body)

    expect(invoice["data"].count).to eq(2)
  end
  it "can call a random resource" do
    create_list(:invoice, 3)

    get "/api/v1/invoices/random.json"

    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random.count).to eq(1)
    expect(random["data"]["type"]).to eq("invoice")
  end
end
