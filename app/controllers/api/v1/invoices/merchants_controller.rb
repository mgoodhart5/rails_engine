class Api::V1::Invoices::MerchantsController < ApplicationController

  def show
    merchant = Invoice.find(params[:id]).merchant
    render json: AssociatedMerchantSerializer.new(merchant)
  end

end
