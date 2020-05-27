class AddDefaultValueToEarningCategory < ActiveRecord::Migration[6.0]
  def change
    change_column :earnings, :category, :string, default: "Prize money"
  end
end
