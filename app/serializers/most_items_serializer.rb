class MostItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price
end
