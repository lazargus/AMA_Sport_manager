class ChangeColumnTypeTournament < ActiveRecord::Migration[6.0]
  def change
    change_column :tournaments, :total_prize_money, :string
  end
end
