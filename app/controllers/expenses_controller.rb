class ExpensesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_expense, only: [:show, :update]

  def index
    @tournaments = current_user.tournaments.where('tournaments.end_date >?', Date.today)
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

  def update
    if @expense.update(expense_params)
      redirect_to expense_path(@expense), notice: 'Expense was successfully added.'
    else
      render :show
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :amount, :title, :category, :done, :tournament_id)
  end
end

