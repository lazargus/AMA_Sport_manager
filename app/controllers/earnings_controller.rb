class EarningsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_earning, only: [ :show, :edit, :update]

  def index
    @earnings = if params[:only_past_earnings] == 'true'
                  current_user.earnings.joins(:tournament).where('tournaments.end_date <?', Date.today)
                elsif params[:only_past_earnings] == 'false'
                  current_user.earnings.joins(:tournament).where('tournaments.end_date >?', Date.today)
                else
                  current_user.earnings.joins(:tournament)
                end
  end

  def show
    @expense = Expense.new
    @tournament = @earning.tournament
  end

  def new
    @earning = Earning.new
  end

  def create
    @earning = Earning.new(earning_params)
    @earning.user = current_user
    if @earning.save
      if earning.tournament
        redirect_to earning_path(@earning)
      else
        redirect_to earnings_path
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @earning.update(earning_params)
      redirect_to earning_path(@earning), notice: 'Earning was successfully added.'
    else
      render :edit
    end
  end

  private

  def set_earning
    @earning = Earning.find(params[:id])
  end

  def earning_params
    params.require(:earning).permit(:date, :forecast_amount, :title, :category, :tournament_id)
  end

end
