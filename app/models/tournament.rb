class Tournament < ApplicationRecord
  has_many :expenses
  has_many :earnings
end
