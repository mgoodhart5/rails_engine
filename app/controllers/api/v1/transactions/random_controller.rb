class Api::V1::Transactions::RandomController < ApplicationController

  def show
    item = Transaction.limit(1).order(Arel.sql("RANDOM()")).first
    render json: TransactionSerializer.new(item)
  end

end
