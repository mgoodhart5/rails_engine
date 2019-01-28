class Api::V1::Items::BestDayController < ApplicationController

  def show
    item = Item.find(params[:id]).best_day[0]
    render json: BestDaySerializer.new(item)
  end

end
