FactoryBot.define do
  factory :merchant do
    sequence :name do |n|
      "merchant_#{n}"
    end
  end
end
