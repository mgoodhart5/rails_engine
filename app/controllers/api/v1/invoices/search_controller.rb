class Api::V1::Invoices::SearchController < ApplicationController

  def index
    if params[:id]
      render json: InvoiceSerializer.new(Invoice.find_by(id: params[:id]))
    elsif params[:status]
      render json: InvoiceSerializer.new(Invoice.where(status: params[:status]))
    elsif params[:created_at]
      render json: InvoiceSerializer.new(Invoice.where(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: InvoiceSerializer.new(Invoice.where(updated_at: params[:updated_at]))
    elsif params[:customer]
      render json: InvoiceSerializer.new(Invoice.where(created_at: params[:created_at]))
    elsif params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: params[:merchant_id]))
    end
  end

  def show
    if params[:id]
      render json: InvoiceSerializer.new(Invoice.find_by(id: params[:id]))
    elsif params[:status]
      render json: InvoiceSerializer.new(Invoice.where(status: params[:status]).first)
    elsif params[:created_at]
      render json: InvoiceSerializer.new(Invoice.where(created_at: params[:created_at]).first)
    elsif params[:updated_at]
      render json: InvoiceSerializer.new(Invoice.where(updated_at: params[:updated_at]).first)
    elsif params[:customer_id]
      render json: InvoiceSerializer.new(Invoice.where(customer_id: params[:customer_id]).first)
    elsif params[:merchant_id]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: params[:merchant_id]).first)
    end
  end
end
