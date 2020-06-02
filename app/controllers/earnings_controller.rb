class EarningsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_earning, only: [ :show, :edit, :update]

  def index
    respond_to do |format| 
      format.html do 
        @earnings = if params[:only_past_earnings] == 'true'
                  current_user.earnings.joins(:tournament).where('tournaments.end_date <?', Date.today)
                elsif params[:only_past_earnings] == 'false'
                  current_user.earnings.joins(:tournament).where('tournaments.end_date >?', Date.today)
                else
                  current_user.earnings.joins(:tournament)
                end
      end
      format.json do
        render json: format_data(current_user.earnings).as_json
      end
    end

  end

  def show
    @expense = Expense.new
    @tournament = Tournament.geocoded
    @tournament = @earning.tournament

    @marker = { lat: @tournament.latitude,
                lng: @tournament.longitude,
                # infoWindow: render_to_string(partial: "info_window", locals: { hotel: hotel })
              }
  end

  def new
    @earning = Earning.new
  end

  def create
    @earning = Earning.new(earning_params)
    @earning.user = current_user
    if @earning.save
      if @earning.tournament
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

  def format_data(data)
    formatted_data = data.group_by {|e| e.date.beginning_of_month}
                        .transform_values {|v| v.pluck(:real_amount).reduce(:+)}
                        .to_a
                        .sort_by(&:first)
                        .last(12)
    {
      labels: formatted_data.map(&:first),
      datasets: [{
        label: "Real Earnings",
        data: formatted_data.map(&:second),
        backgroundColor: [
          "#033860"
        ]
      }]
    }
  end

end
