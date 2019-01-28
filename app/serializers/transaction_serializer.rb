class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :credit_card_number, :id, :result, :invoice_id
end
