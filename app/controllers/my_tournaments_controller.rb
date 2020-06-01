class MyTournamentsController < ApplicationController

  def index
    # @tournaments = current_user.tournaments

    @tournaments = if params[:only_past_tournaments] == 'true'
                  current_user.tournaments.where('tournaments.end_date <?', Date.today)
                elsif params[:only_past_tournaments] == 'false'
                  current_user.tournaments.where('tournaments.end_date >?', Date.today)
                else
                  current_user.tournaments
                end
  end

  def create
    @tournament = Tournament.find(params[:tournament])
    @earning = Earning.new(date: Date.today, title: "prize money", category: "Prize money")

    @earning.user = current_user

    @earning.tournament = @tournament

    if @earning.save
      redirect_to my_tournaments_path
    else
      render "tournaments/show"
    end
  end
end
