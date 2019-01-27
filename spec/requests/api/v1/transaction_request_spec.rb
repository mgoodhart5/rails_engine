require 'rails_helper'

describe "Transactions API" do
  it "sends a list of tranactions" do
    create_list(:transaction, 3)

    get "/api/v1/transactions"

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions["data"].count).to eq(3)
  end
  it "can find one transaction by id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"].to_i).to eq(id)
  end
  it "can find one transaction by id and specific path" do
    id = create(:transaction).id.to_s

    get "/api/v1/transactions/find?id=#{id}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"]["id"]).to eq(id)
  end
  it "can find one transaction by result and specific path" do
    result = create(:transaction).result

    get "/api/v1/transactions/find?result=#{result}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"][0]["attributes"]["result"]).to eq(result)
  end
  it "can find a transaction by created at" do
    transaction_1 = create(:transaction, created_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/transactions/find?created_at=#{transaction_1.created_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"][0]["id"].to_i).to eq(transaction_1.id)
  end
  it "can find a transaction by updated at" do
    transaction_1 = create(:transaction, updated_at: "2012-03-27 14:54:10 UTC")

    get "/api/v1/transactions/find?updated_at=#{transaction_1.updated_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"][0]["id"].to_i).to eq(transaction_1.id)
  end
  it "can find all transaction by created at" do
    transaction_1 = create(:transaction, created_at: "2012-03-27 14:54:09 UTC")
    transaction_2 = create(:transaction, created_at: "2012-03-27 14:54:09 UTC")
    transaction_3 = create(:transaction, created_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/transactions/find_all?created_at=#{transaction_1.created_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"].count).to eq(2)
  end
  it "can find all transaction by updated at" do
    transaction_1 = create(:transaction, updated_at: "2012-03-27 14:54:09 UTC")
    transaction_2 = create(:transaction, updated_at: "2012-03-27 14:54:09 UTC")
    transaction_3 = create(:transaction, updated_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/transactions/find_all?updated_at=#{transaction_1.updated_at}"

    expect(response).to be_successful

    transaction = JSON.parse(response.body)

    expect(transaction["data"].count).to eq(2)
  end
  it "can call a random resource" do
    create_list(:transaction, 3)

    get "/api/v1/transactions/random.json"

    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random.count).to eq(1)
    expect(random["data"]["type"]).to eq("transaction")
  end
end
