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
    elsif params[:quantity]
      render json: ItemSerializer.new(Item.where(quantity: params[:quantity]))
    elsif params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    elsif params[:unit_price]
      render json: ItemSerializer.new(Item.where(unit_price: params[:unit_price]))
    elsif params[:description]
      render json: ItemSerializer.new(Item.where(description: params[:description]))
    elsif params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]))
    end
  end

  def show
    if params[:id]
      render json: ItemSerializer.new(Item.find(params[:id]))
    elsif params[:name]
      render json: ItemSerializer.new(Item.where("name ILIKE '#{params[:name]}'").first)
    elsif params[:quantity]
      render json: ItemSerializer.new(Item.where(quantity: params[:quantity]).first)
    elsif params[:created_at]
      render json: ItemSerializer.new(Item.where(created_at: params[:created_at]).first)
    elsif params[:updated_at]
      render json: ItemSerializer.new(Item.where(updated_at: params[:updated_at]).first)
    elsif params[:unit_price]
      render json: ItemSerializer.new(Item.where(unit_price: params[:unit_price]).first)
    elsif params[:description]
      render json: ItemSerializer.new(Item.where(description: params[:description]).first)
    elsif params[:merchant_id]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]).first)
    end
  end
end
