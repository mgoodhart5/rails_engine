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
  # it "can find one merchants by id and specific path" do
  #   id = create(:merchants).id.to_s
  #
  #   get "/api/v1/merchants/find?id=#{id}"
  #
  #   expect(response).to be_successful
  #
  #   merchants = JSON.parse(response.body)
  #
  #   expect(merchants["data"]["id"]).to eq(id)
  # end
  # it "can find one merchants by name and specific path" do
  #   first_name = create(:merchants).first_name
  #
  #   get "/api/v1/merchants/find?first_name=#{first_name}"
  #
  #   expect(response).to be_successful
  #
  #   merchants = JSON.parse(response.body)
  #
  #   expect(merchants["data"]["attributes"]["first_name"]).to eq(first_name)
  # end
  # it "can find one merchants by name and specific path" do
  #   last_name = create(:merchants).last_name
  #
  #   get "/api/v1/merchants/find?last_name=#{last_name}"
  #
  #   expect(response).to be_successful
  #
  #   merchants = JSON.parse(response.body)
  #
  #   expect(merchants["data"]["attributes"]["last_name"]).to eq(last_name)
  # end
  # xit "can find one merchants by name case insensitive" do
  #   first_name = create(:merchants).first_name
  #
  #   get "/api/v1/merchants/find?first_name=#{first_name.upcase}"
  #
  #   expect(response).to be_successful
  #
  #   merchants = JSON.parse(response.body)
  #
  #   expect(merchants["data"]["attributes"]["last_name"]).to eq(last_name)
  # end
  # xit "can find a merchants by created at" do
  #   # first_name = create(:merchants).first_name
  #   #
  #   # get "/api/v1/merchants/find?first_name=#{first_name.upcase}"
  #   #
  #   # expect(response).to be_successful
  #   #
  #   # merchants = JSON.parse(response.body)
  #
  #   expect(merchants["data"]["attributes"]["last_name"]).to eq(last_name)
  # end
  # xit "can find a merchants by updated at" do
  #   # first_name = create(:merchants).first_name
  #   #
  #   # get "/api/v1/merchants/find?first_name=#{first_name.upcase}"
  #   #
  #   # expect(response).to be_successful
  #   #
  #   # merchants = JSON.parse(response.body)
  #   #
  #   # expect(merchants["data"]["attributes"]["last_name"]).to eq(last_name)
  # end
  # it "can find all merchants" do
  #   merchants = create_list(:merchants, 3)
  #
  #   get "/api/v1/merchants/find_all?id=#{merchants.last.id}"
  #
  #   expect(response).to be_successful
  #
  #   merchants = JSON.parse(response.body)
  #
  #   expect(merchants.count).to eq(1)
  # end
  # it "can find all merchants by first_name" do
  #   merchants_1  = create(:merchants, first_name: "Mary")
  #   merchants_2  = create(:merchants, first_name: "Mary")
  #   merchants_3  = create(:merchants, first_name: "Jes")
  #
  #   get "/api/v1/merchants/find_all?first_name=#{merchants_1.first_name}"
  #
  #   expect(response).to be_successful
  #
  #   merchants = JSON.parse(response.body)
  #
  #   expect(merchants["data"].count).to eq(2)
  # end
  # it "can find all merchants by last_name" do
  #   merchants_1  = create(:merchants, last_name: "Perez")
  #   merchants_2  = create(:merchants, last_name: "Perez")
  #   merchants_3  = create(:merchants, last_name: "Smith")
  #
  #   get "/api/v1/merchants/find_all?last_name=#{merchants_1.last_name}"
  #
  #   expect(response).to be_successful
  #
  #   merchants = JSON.parse(response.body)
  #
  #   expect(merchants["data"].count).to eq(2)
  # end
  # it "can call a random resource" do
  #   create_list(:merchants, 3)
  #
  #   get "/api/v1/merchants/random.json"
  #
  #   expect(response).to be_successful
  #
  #   random = JSON.parse(response.body)
  #
  #   expect(random.count).to eq(1)
  #   expect(random["data"]["type"]).to eq("merchants")
  # end
  it 'returns X merchants ranked by total revenue' do
    m1, m2, m3, m4, m5 = create_list(:merchant)

    item_1 
    item_2
    item_3
    item_4
    item_5
  end
end
