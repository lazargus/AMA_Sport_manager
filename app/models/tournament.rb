class Tournament < ApplicationRecord
  has_one_attached :photo
  has_one_attached :logo

  has_many :expenses, dependent: :destroy
  has_many :earnings, dependent: :destroy

  before_create :data_for_qualifiers
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

  def finished?
    end_date < Date.today
  end

  # def find_user_earning
  #   Earning.find_by(tournament/tournament_id)
  # end

  def data_for_qualifiers
    @tournament_data = JSON.parse(self.data)
    if @tournament_data['Qualifier 2']
      @q2 = @tournament_data['Qualifier 2']['prize_money']
      if @tournament_data['Qualifier']['prize_money'] == 0
        @tournament_data['Qualifier']['prize_money'] = @q2 * 2
        @tournament_data['Qualifier 3']['prize_money'] = @q2 * 2
        self.data = @tournament_data.to_json
      end
    end

    # sur Qualifier et Qualifier 3
    # pour chaque pair verifier la valeur de prize money
    # si prize money = 0
    # assigner nouvelle valeur a prize money (/10?)
    # update instance du tournoi avec nouvelles valeurs de q1
    # Reparser en json (tournoi.update(data.to_json))
  end
end
