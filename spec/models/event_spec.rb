require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:bookings).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:event_date) }
    it { is_expected.to validate_presence_of(:total_tickets) }

    context 'total tickets validation on update' do
      let(:event) { create(:event, total_tickets: 100) }
      let!(:booking) { create(:booking, event: event, ticket_quantity: 30) }

      it 'does not allow reducing total tickets below booked quantity' do
        event.total_tickets = 20
        expect(event.valid?).to be false
        expect(event.errors[:total_tickets]).to include(" - Already booked 30 tickets.")
      end

      it 'allows increasing total tickets' do
        event.total_tickets = 200
        expect(event.valid?).to be true
      end
    end
  end
end