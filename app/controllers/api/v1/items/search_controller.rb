class Api::V1::Items::SearchController < ApplicationController

  def index
    if params[:id]
      render json: ItemSerializer.new(Item.where(id: params[:id]))
    elsif params[:name]
      render json: ItemSerializer.new(Item.where(name: params[:name]))
    elsif params[:created_at]
      render json: ItemSerializer.new(Item.where(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: ItemSerializer.new(Item.where(updated_at: params[:updated_at]))
    elsif params[:merchant]
      render json: ItemSerializer.new(Item.where(merchant: params[:merchant]))
    end
  end

  def show
    if params[:id]
      render json: ItemSerializer.new(Item.find(params[:id]))
    elsif params[:name]
      render json: ItemSerializer.new(Item.where("name ILIKE '#{params[:name]}'").first)
    elsif params[:created_at]
      render json: ItemSerializer.new(Item.where(created_at: params[:created_at]).first)
    elsif params[:updated_at]
      render json: ItemSerializer.new(Item.where(updated_at: params[:updated_at]).first)
    end
  end
end
