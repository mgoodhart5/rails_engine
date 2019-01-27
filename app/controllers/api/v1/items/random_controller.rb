class Api::V1::Items::RandomController < ApplicationController

  def show
    item = Item.limit(1).order(Arel.sql("RANDOM()")).first
    render json: ItemSerializer.new(item)
  end

end
