class Earning < ApplicationRecord
  CATEGORY = ['Prize money', 'Sponsor', 'Subsidy', 'Other']
  belongs_to :tournament, optional: true
  belongs_to :user

  validates :category, presence: true
  validates :category, inclusion: { in: CATEGORY }
end
