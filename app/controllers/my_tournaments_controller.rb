class MyTournamentsController < ApplicationController

  def index
    @tournaments = current_user.tournaments
  end

  def create
    @tournament = Tournament.find(params[:tournament])
    @earning = Earning.new(date: Date.today, forecast_amount: 1000, title: "prize money", category: "Prize money")

    @earning.user = current_user

    @earning.tournament = @tournament

    if @earning.save
      redirect_to my_tournaments_path
    else
      render "tournaments/show"
    end
  end
end
