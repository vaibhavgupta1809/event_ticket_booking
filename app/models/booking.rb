class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :ticket_quantity, presence: true
  validate :ticket_quantity_with_available_tickets

  private

  def ticket_quantity_with_available_tickets
    return unless event && ticket_quantity.present?

    if ticket_quantity > (event.total_tickets - event.bookings.sum(:ticket_quantity))
      errors.add(:ticket_quantity, "cannot exceed available tickets")
    end
  end
end
