class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :events, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booked_events, through: :bookings, source: :event

  validates :first_name, :last_name, presence: true

  def admin?
    role == 'admin'
  end
end
