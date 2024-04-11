class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :ticket_quantity, presence: true
end
