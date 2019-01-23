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
  it "can find one customer by name and specific path" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end
  it "can find one customer by name and specific path" do
    last_name = create(:customer).last_name

    get "/api/v1/customers/find?last_name=#{last_name}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
  end
  xit "can find one customer by name case insensitive" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name.upcase}"

    expect(response).to be_successful

    customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
  end
  xit "can find a customer by created at" do
    # first_name = create(:customer).first_name
    #
    # get "/api/v1/customers/find?first_name=#{first_name.upcase}"
    #
    # expect(response).to be_successful
    #
    # customer = JSON.parse(response.body)

    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
  end
  xit "can find a customer by updated at" do
    # first_name = create(:customer).first_name
    #
    # get "/api/v1/customers/find?first_name=#{first_name.upcase}"
    #
    # expect(response).to be_successful
    #
    # customer = JSON.parse(response.body)
    #
    # expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
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
end
