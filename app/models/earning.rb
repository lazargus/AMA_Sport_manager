class Earning < ApplicationRecord
  CATEGORY = ['Prize money', 'Sponsor', 'Subsidy', 'Family', 'Advertising', 'Exhibition','Other']
  belongs_to :tournament, optional: true
  belongs_to :user

  validates :category, presence: true
  validates :category, inclusion: { in: CATEGORY }

  def collection_for_simple_form
    return [] if tournament.nil?
    result = []
    JSON.parse(tournament.data).each_pair do |k, v|
      result << ["#{k}: $#{v["prize_money"]}", v["prize_money"]]
    end
    return result
  end

  def collected?
    real_amount > 0
  end

end
