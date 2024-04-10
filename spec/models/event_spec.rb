require 'rails_helper'

RSpec.describe Event, type: :model do

  describe "custom methods" do
    describe "#remaining_tickets" do
      let(:event) { create(:event, total_tickets: 100) }
      let!(:booking1) { create(:booking, event: event, ticket_quantity: 20) }
      let!(:booking2) { create(:booking, event: event, ticket_quantity: 30) }

      it "returns the correct number of remaining tickets" do
        create_list(:ticket,20, event: event, booking: booking1)
        create_list(:ticket,30, event: event, booking: booking2)
        expect(event.remaining_tickets).to eq(50)
      end

      context "when there are no bookings" do
        before do
          booking1.destroy
          booking2.destroy
        end
        
        it "returns the total number of tickets" do
          expect(event.remaining_tickets).to eq(event.total_tickets)
        end
      end
    end
  end
end