class BestDaySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id

  attributes :best_day do |object|
    object.updated_at
  end

end
