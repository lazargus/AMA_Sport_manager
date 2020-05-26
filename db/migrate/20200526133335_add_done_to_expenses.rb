class AddDoneToExpenses < ActiveRecord::Migration[6.0]
  def change
    add_column :expenses, :done, :boolean, default: false
  end
end
