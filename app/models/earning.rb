class Earning < ApplicationRecord
  CATEGORY = ['Prize money', 'Sponsor', 'Subsidy', 'Family', 'Advertising', 'Exhibition','Other']
  belongs_to :tournament, optional: true
  belongs_to :user

  validates :category, :date, presence: true
  validates :category, inclusion: { in: CATEGORY }
end
