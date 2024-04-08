class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :attendees, through: :bookings, source: :user

  self.locking_column = :lock_version
end
