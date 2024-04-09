class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :tickets, through: :bookings
  has_many :attendees, through: :bookings, source: :user

  self.locking_column = :lock_version

  def remaining_tickets
    total_tickets - tickets.count
  end
end
