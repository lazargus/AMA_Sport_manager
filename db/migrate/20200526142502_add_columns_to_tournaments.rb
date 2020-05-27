class AddColumnsToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :participants, :integer
    add_column :tournaments, :official_link, :string
    add_column :tournaments, :description, :text
    add_column :tournaments, :last_winner, :string
  end
end
