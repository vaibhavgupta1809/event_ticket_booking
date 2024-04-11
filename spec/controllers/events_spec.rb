require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:event) { create(:event, user: user) }

  before do
    sign_in user
  end
  
  describe "GET #index" do
    it "populates an array of all events" do
      get :index
      expect(assigns(:events)).to eq([event])
    end
  end

  describe "GET #new" do
    it "assigns a new Event to @event" do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe "GET #edit" do
    it "assigns the requested event to @event" do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new event" do
        expect {
          post :create, params: { event: attributes_for(:event) }
        }.to change(Event, :count).by(1)
      end

      it "redirects to the event index" do
        post :create, params: { event: attributes_for(:event) }
        expect(response).to redirect_to(my_events_and_bookings_path)
      end
    end

    context "with invalid attributes" do
      it "does not save the new event" do
        expect {
          post :create, params: { event: attributes_for(:event, name: nil) }
        }.not_to change(Event, :count)
      end

      it "re-renders the 'new' template" do
        post :create, params: { event: attributes_for(:event, name: nil) }
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    context "with valid attributes" do
      it "updates the event" do
        put :update, params: { id: event.id, event: { name: "Updated Event" } }
        event.reload
        expect(event.name).to eq("Updated Event")
      end

      it "redirects to the event index" do
        put :update, params: { id: event.id, event: { name: "Updated Event" } }
        expect(response).to redirect_to(my_events_and_bookings_path)
      end
    end

    context "with invalid attributes" do
      it "does not update the event" do
        put :update, params: { id: event.id, event: { name: nil } }
        event.reload
        expect(event.name).not_to be_nil
      end

      it "re-renders the 'edit' template" do
        put :update, params: { id: event.id, event: { name: nil } }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the event" do
      delete :destroy, params: { id: event.id }
      expect(Event.exists?(event.id)).to be false
    end

    it "redirects to events#index" do
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to my_events_and_bookings_path
    end
  end

  # Additional tests for user_event_and_bookings and caching can be added as needed.
end