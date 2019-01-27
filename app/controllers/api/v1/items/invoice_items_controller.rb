class Api::V1::Items::InvoiceItemsController < ApplicationController

  def show
    invoice_items = Item.find(params[:id]).invoice_items
    render json: AssociatedInvoiceItemSerializer.new(invoice_items)
  end

end
