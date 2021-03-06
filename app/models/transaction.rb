class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number
  belongs_to :invoice

  enum result: ["success", "failed"] 
end
