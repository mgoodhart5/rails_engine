FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status { true }
  end
end
