class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: {data: {revenue_per_date: {all_merchants: (Merchant.revenue(params[:date]))}}}
  end

  def show
    merchant = Merchant.find(params[:id])
    merchant_name = merchant.name
    merchant_id = merchant.id
    render json: {data: {id: merchant_id, merchant: merchant_name, revenue: merchant.total_revenue}}
  end

end
