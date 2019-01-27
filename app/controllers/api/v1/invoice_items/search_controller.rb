class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    if params[:id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(id: params[:id]))
    elsif params[:quantity]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(quantity: params[:quantity]))
    elsif params[:created_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(updated_at: params[:updated_at]))
    elsif params[:item]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(item: params[:item]))
    elsif params[:invoice]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice: params[:invoice]))
    end
  end

  def show
    if params[:id]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(id: params[:id]))
    elsif params[:quantity]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(quantity: params[:quantity]))
    elsif params[:created_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(updated_at: params[:updated_at]))
    elsif params[:item]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(item: params[:item]))
    elsif params[:invoice]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice: params[:invoice]))
    end
  end
end
