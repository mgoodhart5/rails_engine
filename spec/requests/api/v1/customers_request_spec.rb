require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(3)
  end
  it "can find one customer by id" do
    id = create(:customer).id.to_s

    get "/api/v1/customers/#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"]).to eq(id)
  end
  it "can find one customer by id and specific path" do
    id = create(:customer).id.to_s

    get "/api/v1/customers/find?id=#{id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["id"]).to eq(id)
  end
  it "can find one customer by first name and specific path" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end
  it "can find one customer by last name and specific path" do
    last_name = create(:customer).last_name

    get "/api/v1/customers/find?last_name=#{last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
  end
  it "can find one customer by name case insensitive" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name.upcase}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end
  it "can find a customer by created at" do
    customer_1 = create(:customer, created_at: "2012-03-27 14:54:09 UTC")

    get "/api/v1/customers/find?created_at=#{customer_1.created_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["id"]).to eq(customer_1.id)
  end
  it "can find a customer by updated at" do
    customer_1 = create(:customer, updated_at: "2012-03-27 14:54:10 UTC")

    get "/api/v1/customers/find?updated_at=#{customer_1.updated_at}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["id"]).to eq(customer_1.id)
  end
  it "can find all customers" do
    customers = create_list(:customer, 3)

    get "/api/v1/customers/find_all?id=#{customers.last.id}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer.count).to eq(1)
  end
  it "can find all customers by first_name" do
    customer_1  = create(:customer, first_name: "Mary")
    customer_2  = create(:customer, first_name: "Mary")
    customer_3  = create(:customer, first_name: "Jes")

    get "/api/v1/customers/find_all?first_name=#{customer_1.first_name}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(2)
  end
  it "can find all customers by last_name" do
    customer_1  = create(:customer, last_name: "Perez")
    customer_2  = create(:customer, last_name: "Perez")
    customer_3  = create(:customer, last_name: "Smith")

    get "/api/v1/customers/find_all?last_name=#{customer_1.last_name}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(2)
  end
  it "can call a random resource" do
    create_list(:customer, 3)

    get "/api/v1/customers/random.json"

    expect(response).to be_successful

    random = JSON.parse(response.body)

    expect(random.count).to eq(1)
    expect(random["data"]["type"]).to eq("customer")
  end
  it "can find all customers by created at" do
    customer_1 = create(:customer, created_at: "2012-03-27 14:54:09 UTC")
    customer_2 = create(:customer, created_at: "2012-03-27 14:54:09 UTC")
    customer_3 = create(:customer, created_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/customers/find_all?created_at=#{customer_1.created_at}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(2)
  end
  it "can find all customers by updated at" do
    customer_1 = create(:customer, updated_at: "2012-03-27 14:54:09 UTC")
    customer_2 = create(:customer, updated_at: "2012-03-27 14:54:09 UTC")
    customer_3 = create(:customer, updated_at: "2012-03-25 14:54:09 UTC")

    get "/api/v1/customers/find_all?updated_at=#{customer_1.updated_at}"

    expect(response).to be_successful

    customers = JSON.parse(response.body)

    expect(customers["data"].count).to eq(2)
  end
  it 'returns fav merchant with most successful transactions' do
    customer = create(:customer)
    m1 = create(:merchant)
    m2 = create(:merchant)

    item_1 = create(:item, merchant: m2, unit_price: 400)
    item_2 = create(:item, merchant: m2, unit_price: 300)
    item_3 = create(:item, merchant: m1, unit_price: 500)

    invoice_1 = create(:invoice, customer: customer, merchant: m2)
    invoice_2 = create(:invoice, customer: customer, merchant: m1)
    invoice_3 = create(:invoice, customer: customer, merchant: m1)

    invoice_item_1 = create(:invoice_item, quantity: 1, unit_price: 1500, item_id: item_2.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, quantity: 2, unit_price: 500, item_id: item_3.id, invoice_id: invoice_2.id)
    invoice_item_3 = create(:invoice_item, quantity: 3, unit_price: 400, item_id: item_1.id, invoice_id: invoice_3.id)


    transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
    transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
    transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    expect(response).to be_successful

    merch = JSON.parse(response.body)

    expect(merch["data"]["id"].to_i).to eq(m1.id)
  end
end
