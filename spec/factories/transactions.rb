FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number { 1234567891010 }
    credit_card_expiration_date { "2019-01-23" }
    result { true }
  end
end
