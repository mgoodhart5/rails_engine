class Api::V1::Items::MerchantsController < ApplicationController

  def show
    merchant = Item.find(params[:id]).merchant
    render json: AssociatedMerchantSerializer.new(merchant)
  end

end
