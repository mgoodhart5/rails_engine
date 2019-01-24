FactoryBot.define do
  factory :item do
    sequence :name do |n|
      "item_#{n}"
    end
    sequence :description do |n|
      "description_for_item_#{n}"
    end
    unit_price { 1 }
    merchant
  end
end
