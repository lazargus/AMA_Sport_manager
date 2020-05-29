class Tournament < ApplicationRecord
  has_many :expenses
  has_many :earnings

  has_one_attached :photo
  has_one_attached :logo

  has_many :expenses, dependent: :destroy
  has_many :earnings, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  scope :not_started, ->{where('start_date > ?', Date.today)}

  def data_for_calendar
    {
      title: name,
      start: start_date.strftime("%Y-%m-%d"),
      end: end_date.strftime("%Y-%m-%d"),
      id: id
    }
  end
end
