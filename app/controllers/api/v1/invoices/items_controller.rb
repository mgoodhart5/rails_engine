class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    render json: AssociatedItemSerializer.new(Invoice.find(params[:id]).all_items)
  end

end
