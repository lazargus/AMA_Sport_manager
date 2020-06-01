class DashboardController < ApplicationController
  def index
    @earnings = Earning.all
    @expenses = Expense.all
  end
end
