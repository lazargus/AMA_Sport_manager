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

  def donut
    respond_to do |format|
      format.json do
        render json: format_data_donut(current_user.expenses).as_json
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
    if @expense.tournament
      @tournament = Tournament.find(params[:expense][:tournament_id])
      @earning = Earning.find(params[:expense][:earning])
    end
    if @expense.save
      if @expense.tournament
        redirect_to '#expense'
      else
        redirect_to dashboard_index_path
      end
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

  def create_multiple
    if multiple_expenses_params[:expenses_attributes]["1"]
      current_user.expense_amount = multiple_expenses_params[:expenses_attributes]["1"][:amount]
    end
    @earning = Earning.find(params[:earning_id])
    current_user.update!(multiple_expenses_params)
    redirect_to earning_path(@earning)
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :amount, :title, :category, :done, :tournament_id)
  end

  def multiple_expenses_params
    params.require(:user).permit(expenses_attributes: [:date, :amount, :title, :category, :done, :tournament_id, :user_id])
  end

  def format_data(data)
    formatted_data = data.group_by {|e| e.date.beginning_of_month}
                        .transform_values {|v| v.pluck(:amount).reduce(:+)}
                        .to_a
                        .sort_by(&:first)
                        .last(12)
    {
        label: "Expenses",
        data: formatted_data.map(&:second),
        backgroundColor: [
          'rgba(253, 94, 83, 0.6)'
        ]
    }
  end

  def format_data_donut(data)
    formatted_data = data.group_by {|e| e.category}
                        .transform_values {|v| v.pluck(:amount).reduce(:+)}
                        .to_a
                        .sort_by(&:first)

    {
      labels: formatted_data.map(&:first),
        datasets: [{
        label: "Categories",
        data: formatted_data.map(&:second),
        backgroundColor: [
          'rgba(3, 56, 96, 0.7)',
          'rgba(249, 200, 2, 0.7)',
          'rgba(253, 94, 83, 0.7)',
          'rgba(33, 191, 115, 0.7)'
        ]
      }]
    }
  end
end
