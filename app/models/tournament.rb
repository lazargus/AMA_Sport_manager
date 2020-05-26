class Tournament < ApplicationRecord
  has_many :expenses
  has_many :earnings

  has_one_attached :photo
  has_one_attached :logo
end
