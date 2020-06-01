class RemoveDoneFromExpenses < ActiveRecord::Migration[6.0]
  def change
    remove_column :expenses, :done, :boolean
  end
end
