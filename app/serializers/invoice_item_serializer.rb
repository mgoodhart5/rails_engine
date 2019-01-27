class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :quantity, :unit_price, :item_id, :invoice_id
end
