require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  describe 'POST #create' do
    let(:user) { create(:user) }
    let(:event) { create(:event, available_tickets: 5) }
    let(:valid_attributes) { { ticket_quantity: 3} }
    let(:invalid_attributes) { { ticket_quantity: 6, event_id: event.id } }  # More tickets than available

    before do
      sign_in user
    end

    context 'with valid parameters' do
      it 'creates a new Booking and decreases the ticket count' do
        expect {
          post :create, params: { booking: valid_attributes, event_id: event.id }
        }.to change(Booking, :count).by(1)
        expect(event.reload.available_tickets).to eq(2)
        expect(response).to redirect_to(my_events_and_bookings_path)
      end
    end

    context 'with invalid parameters (not enough tickets)' do
      it 'does not create a booking' do
        expect {
          post :create, params: { booking: invalid_attributes, event_id: event.id }
        }.to change(Booking, :count).by(0)
        expect(response).to redirect_to(events_path)
      end

      it 'sets an alert message' do
        post :create, params: { booking: invalid_attributes, event_id: event.id }
        expect(flash[:alert]).to eq('Not enough tickets available.')
      end
    end

    context 'when the event does not exist' do
      it 'redirects to the events path with an error' do
        post :create, params: { booking: valid_attributes, event_id: 9999 }
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event not found.')
      end
    end
  end
end