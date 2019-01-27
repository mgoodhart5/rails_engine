class Revenue
  attr_reader :id, :revenue

  def initialize(id = 1, revenue)
    @revenue = revenue
    @id = id
  end

end
