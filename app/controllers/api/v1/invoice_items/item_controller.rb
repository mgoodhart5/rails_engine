class Api::V1::InvoiceItems::ItemController < ApplicationController

  def show
    invoice = InvoiceItem.find(params[:id]).item
    render json: AssociatedItemSerializer.new(invoice)
  end

end
