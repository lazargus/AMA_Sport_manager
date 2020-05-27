class MyTournamentsController < ApplicationController

  def index
    @tournaments = current_user.tournaments
  end
end
