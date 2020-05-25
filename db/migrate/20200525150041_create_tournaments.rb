class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :address
      t.jsonb :prize_money
      t.string :surface
      t.string :category
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
