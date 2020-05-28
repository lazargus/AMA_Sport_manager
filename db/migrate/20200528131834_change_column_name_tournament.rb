class ChangeColumnNameTournament < ActiveRecord::Migration[6.0]
  def change
    rename_column :tournaments, :prize_money, :data
  end
end
