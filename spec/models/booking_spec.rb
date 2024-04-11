require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:ticket_quantity) }
  end

  describe 'creating a booking' do
    let(:user) { create(:user) } 
    let(:event) { create(:event) } 

    it 'successfully creates a booking with valid attributes' do
      booking = Booking.new(
        user: user,
        event: event,
        ticket_quantity: 5
      )
      expect(booking).to be_valid
    end
  end
end