FactoryBot.define do
  factory :customer do
    sequence :first_name do |n|
      "user_#{n}"
    end
    sequence :last_name do |n|
      "user_#{n}"
    end
  end
end
