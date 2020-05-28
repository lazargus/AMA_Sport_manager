class ExpensesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_expense, only: [ :show]

  def index
    @expenses = current_user.tournaments.not_started.map(&:expenses).flatten
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user = current_user
    if @expense.save
      redirect_to expense_path(@expense)
    else
      render :new
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :amount, :title, :category, :done)
  end
end

