class ChangeDefaultForRealAmountInEarnings < ActiveRecord::Migration[6.0]
  def change
    change_column_default :earnings, :real_amount, 0
  end
end
