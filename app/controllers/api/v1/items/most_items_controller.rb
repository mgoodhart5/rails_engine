class Api::V1::Items::MostItemsController < ApplicationController

  def index
    item_items = Item.most_items(params[:quantity])
    render json: MostItemsSerializer.new(item_items)
  end
end
