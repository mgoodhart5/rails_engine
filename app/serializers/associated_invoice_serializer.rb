class AssociatedInvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :merchant_id, :customer_id
end
