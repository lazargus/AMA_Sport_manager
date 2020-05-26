class TournamentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
  end
end
