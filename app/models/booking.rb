class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_many :tickets, dependent: :destroy

  validate :ticket_quantity_with_available_tickets

  private

  def ticket_quantity_with_available_tickets
    return unless event && ticket_quantity.present?

    if ticket_quantity > (event.total_tickets - event.tickets.count)
      errors.add(:ticket_quantity, "cannot exceed available tickets")
    end
  end
end
