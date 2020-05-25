class CreateEarnings < ActiveRecord::Migration[6.0]
  def change
    create_table :earnings do |t|
      t.string :title
      t.string :category
      t.date :date
      t.integer :forecast_amount
      t.integer :real_amount
      t.references :tournament, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
