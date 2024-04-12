class Event < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  
  validates :name, :description, :location, :event_date, :total_tickets, presence: true
  validates :total_tickets, numericality: { greater_than: 0 }
  validate :total_tickets_validate, on: :update

  private

  def total_tickets_validate
    if total_tickets < bookings.sum(:ticket_quantity)
      errors.add(:total_tickets, " - Already booked #{bookings.sum(:ticket_quantity)} tickets.")
    end
  end

end
