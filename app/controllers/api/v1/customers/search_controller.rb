class Api::V1::Customers::SearchController < ApplicationController

  def index
    if params[:id]
      render json: CustomerSerializer.new(Customer.find_by(id: params[:id]))
    elsif params[:first_name]
      render json: CustomerSerializer.new(Customer.where(first_name: params[:first_name]))
    elsif params[:last_name]
      render json: CustomerSerializer.new(Customer.where(last_name: params[:last_name]))
    end
  end

  def show
    if params[:id]
      render json: CustomerSerializer.new(Customer.find(params[:id]))
    elsif params[:first_name]
      render json: CustomerSerializer.new(Customer.where("first_name ILIKE '#{params[:first_name]}'"))
    elsif params[:last_name]
      render json: CustomerSerializer.new(Customer.where("last_name ILIKE '#{params[:last_name]}'"))
    end
  end

end
