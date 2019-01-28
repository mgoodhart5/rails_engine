class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    customer = Customer.find(params[:id])
    merchant = customer.favorite_merchant[0]
    render json: FavoriteMerchantSerializer.new(merchant)
  end

end
