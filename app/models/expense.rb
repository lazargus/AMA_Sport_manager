class Expense < ApplicationRecord
  CATEGORY = ['Flight', 'Hotel', 'Team', 'Other']
  belongs_to :tournament, optional: true
  belongs_to :user

  validates :date, :amount, :title, :category, presence: true, unless: -> {tournament}

  scope :not_started, ->{joins(:tournament).where('tournaments.start_date > ?', Date.today)}

end
