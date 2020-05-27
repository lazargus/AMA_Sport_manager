class ChangeColumnInEarnings < ActiveRecord::Migration[6.0]
  def change
    remove_column :earnings, :category
    add_column :earnings, :category, :string, default: "Prize money"
  end
end
