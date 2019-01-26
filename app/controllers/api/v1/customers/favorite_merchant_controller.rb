class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    customer = Customer.find(params[:id])
    merchant = customer.favorite_merchant
    render json: FavoriteMerchantSerializer.new(merchant)
    #how to do this better?
  end

end
