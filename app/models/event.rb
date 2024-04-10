class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  
  validates :name, :description, :location, :event_date, :total_tickets, presence: true

  def remaining_tickets
    total_tickets - bookings.sum(:ticket_quantity)
  end
end
