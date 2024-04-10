require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }
    let(:event) { create(:event, total_tickets: 50) }

    context 'when ticket_quantity does not exceed available tickets' do
      it 'is valid' do
        booking = build(:booking, user: user, event: event, ticket_quantity: 10)
        expect(booking).to be_valid
      end
    end

    context 'when ticket_quantity exceeds available tickets' do
      it 'is not valid' do
        booking = build(:booking, user: user, event: event, ticket_quantity: 60)
        expect(booking).not_to be_valid
        expect(booking.errors[:ticket_quantity]).to include("cannot exceed available tickets")
      end
    end
  end
end