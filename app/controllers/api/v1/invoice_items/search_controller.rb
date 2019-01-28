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
    elsif params[:item_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(item_id: params[:item_id]))
    elsif params[:invoice_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_id: params[:invoice_id]))
    elsif params[:unit_price]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(unit_price: params[:unit_price]))
    end
  end

  def show
    if params[:id]
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(id: params[:id]))
    elsif params[:quantity]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(quantity: params[:quantity]).first)
    elsif params[:created_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(created_at: params[:created_at]).first)
    elsif params[:updated_at]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(updated_at: params[:updated_at]).first)
    elsif params[:item_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(item_id: params[:item_id]))
    elsif params[:invoice_id]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(invoice_id: params[:invoice_id]))
    elsif params[:unit_price]
      render json: InvoiceItemSerializer.new(InvoiceItem.where(unit_price: params[:unit_price]))
    end
  end
end
