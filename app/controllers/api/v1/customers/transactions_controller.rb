class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    transactions = Customer.find(params[:id]).all_transactions
    render json: AssociatedTransactionSerializer.new(transactions)
  end

end
