class Api::V1::Invoices::RandomController < ApplicationController

  def show
    invoice = Invoice.limit(1).order(Arel.sql("RANDOM()")).first
    render json: InvoiceSerializer.new(invoice)
  end

end
