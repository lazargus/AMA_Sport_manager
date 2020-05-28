class AddColumnToTournament < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :total_prize_money, :integer
  end
end
