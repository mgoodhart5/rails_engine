class Api::V1::Merchants::MostItemsController < ApplicationController

  def index
    merchant_items = Merchant.most_items(params[:quantity])
    render json: MerchantSerializer.new(merchant_items)
  end
end
