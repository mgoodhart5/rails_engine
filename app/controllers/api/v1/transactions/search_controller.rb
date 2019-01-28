class Api::V1::Transactions::SearchController < ApplicationController

  def index
    if params[:id]
      render json: TransactionSerializer.new(Transaction.where(id: params[:id]))
    elsif params[:result]
      render json: TransactionSerializer.new(Transaction.where(result: params[:result]))
    elsif params[:created_at]
      render json: TransactionSerializer.new(Transaction.where(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: TransactionSerializer.new(Transaction.where(updated_at: params[:updated_at]))
    elsif params[:invoice_id]
      render json: TransactionSerializer.new(Transaction.where(invoice_id: params[:invoice_id]))
    end
  end

  def show
    if params[:id]
      render json: TransactionSerializer.new(Transaction.find_by(id: params[:id]))
    elsif params[:result]
      render json: TransactionSerializer.new(Transaction.where(result: params[:result]).first)
    elsif params[:created_at]
      render json: TransactionSerializer.new(Transaction.where(created_at: params[:created_at]))
    elsif params[:updated_at]
      render json: TransactionSerializer.new(Transaction.where(updated_at: params[:updated_at]))
    elsif params[:invoice_id]
      render json: TransactionSerializer.new(Transaction.where(invoice_id: params[:invoice_id]))
    end
  end
end
