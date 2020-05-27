class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :earnings, dependent: :destroy
  has_many :expenses, dependent: :destroy
  validates :first_name, :last_name, presence: true

  def tournaments
    Tournament.find tournament_ids
  end

  private

  def tournament_ids
    [
      earnings.pluck(:tournament_id) +
      expenses.pluck(:tournament_id)
    ].flatten.compact.uniq
  end
end
