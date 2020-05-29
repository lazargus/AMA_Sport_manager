class TournamentExpensesController < ApplicationController

  def new
    @expense = Expense.new
    @tournament = Tournament.find(params[:tournament_id])
  end
end
