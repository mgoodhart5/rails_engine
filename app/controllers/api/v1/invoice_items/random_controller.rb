class Api::V1::InvoiceItems::RandomController < ApplicationController

  def show
    item = InvoiceItem.limit(1).order(Arel.sql("RANDOM()")).first
    render json: InvoiceItemSerializer.new(item)
  end

end
