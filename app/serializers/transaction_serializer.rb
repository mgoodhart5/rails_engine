class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :result, :invoice_id
end
