class ExpensesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_expense, only: [:show, :update]

  def index
    respond_to do |format| 
      format.html do 
        @tournaments = current_user.tournaments.where('tournaments.end_date >?', Date.today)
      end
      format.json do
        render json: format_data(current_user.expenses).as_json
      end
    end
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

  def format_data(data)
    formatted_data = data.group_by {|e| e.date.beginning_of_month}
                        .transform_values {|v| v.pluck(:amount).reduce(:+)}
                        .to_a
                        .sort_by(&:first)
                        .last(12)
    {
      labels: formatted_data.map(&:first),
      datasets: [{
        label: "Expenses",
        data: formatted_data.map(&:second),
        backgroundColor: [
          "#FD1015"
        ]
      }]
    }
  end

end
