require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:user) { create(:user) }
  let(:event) { create(:event) }
  let(:booking) { create(:booking, user: user, event: event) }

  before do
    sign_in user
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new booking" do
        expect {
          post :create, params: {  booking: { event_id: event.id, ticket_quantity: 2 } }
        }.to change(Booking, :count).by(1)
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Tickets successfully booked.')
      end
    end

    context "with invalid parameters" do
      it "does not create a booking" do
        expect {
          post :create, params: {  booking: { event_id: nil, ticket_quantity: nil } }
        }.to change(Booking, :count).by(0)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the booking" do
      booking 
      expect {
        delete :destroy, params: { id: booking.id, event_id: event.id }
      }.to change(Booking, :count).by(-1)
      expect(response).to redirect_to(bookings_url)
    end
  end
end