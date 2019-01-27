class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :result, :invoice_id
end
