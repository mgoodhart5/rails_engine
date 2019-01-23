require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Validations' do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:unit_price)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should belong_to(:merchant)}
  end
end
