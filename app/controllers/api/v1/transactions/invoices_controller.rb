class Api::V1::Transactions::InvoicesController < ApplicationController

  def show
    invoice = Transaction.find(params[:id]).invoice
    render json: AssociatedInvoiceSerializer.new(invoice)
  end

end
