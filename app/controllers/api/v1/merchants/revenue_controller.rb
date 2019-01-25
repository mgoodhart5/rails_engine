class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: {revenue_per_date: {all_merchants: (Merchant.revenue(params[:date]))}}
  end

end
