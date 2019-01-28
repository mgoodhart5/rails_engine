class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    revenue_obj = Revenue.new("all merchants", Merchant.revenue(params[:date]))
    render json: RevenueSerializer.new(revenue_obj)
  end

  def show
    merchant = Merchant.find(params[:id])
    total_revenue = merchant.total_revenue
    total_revenue_obj = Revenue.new("#{merchant.id}", total_revenue)
    render json: TotalRevenueSerializer.new(total_revenue_obj)
  end

end
