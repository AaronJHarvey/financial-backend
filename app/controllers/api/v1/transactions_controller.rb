class Api::v1::TransactionsController < ApplicationController
  before_action :set_account

  def index
    @transactions = @account.transactions
    render json: @transactions
  end

  def create
    @transaction = @account.transactions.new(transaction_params)
    if @account.update_balance(@transaction) != "Insufficient Funds"
      @transaction.save
      render json: @transaction
    else
      render json: {error: "Insufficient Funds"}
    end
  end

  def show
    @transaction = @account.transactions.find_by(id: params[:id])
    render json: @transaction
  end

  def destroy
  end

  private

    def set_account
      @account = Account.find(params[:account_id])
    end

    def transaction_params
      params.require(:transaction).permit(:amount, :account_id, :kind, :date, :description)
    end

  end
