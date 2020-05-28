class Tournament < ApplicationRecord
  has_many :expenses
  has_many :earnings

  has_one_attached :photo
  has_one_attached :logo

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  scope :not_started, ->{where('start_date > ?', Date.today)}
end
