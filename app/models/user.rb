class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :earnings, dependent: :destroy
  has_many :expenses, dependent: :destroy
  has_many :tournaments, through: :earnings
  has_many :tournaments, through: :expenses
end
