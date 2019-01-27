class MostRevenueItemsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :description, :unit_price
end
