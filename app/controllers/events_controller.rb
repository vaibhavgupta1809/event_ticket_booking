class EventsController < ApplicationController
  before_action :set_event, only: %i[ edit update destroy ]
  skip_before_action :authenticate_user!, only: [:index]
  

  def index
    @events = Rails.cache.fetch("events/all", expires_in: 1.hours) do
      Event.all.to_a
    end
  end

  def new
    @event = current_user.events.new
  end

  def edit
  end

  def create
    @event = current_user.events.new(event_params.merge(available_tickets: event_params[:total_tickets]))

    if @event.save
      Rails.cache.delete('events/all')
      redirect_to my_events_and_bookings_path, notice: "Event was successfully created." 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @event.available_tickets = event_params[:total_tickets].to_i - @event.bookings.sum(:ticket_quantity) if @event.valid?
    if @event.update(event_params)
      Rails.cache.delete('events/all')
      flash[:notice] = 'Event was successfully updated.'
      redirect_to my_events_and_bookings_path
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    if @event.destroy
      Rails.cache.delete('events/all')
      redirect_to my_events_and_bookings_path, notice: "Event was successfully destroyed."
    else
      redirect_to my_events_and_bookings_path, alert: "Failed to destroy event."
    end
  end

  def user_event_and_bookings
  end

  private
    def set_event
      @event = Event.find_by(id: params[:id])
      unless @event
        redirect_to my_events_and_bookings_path, notice: "Event not found."
      end
    end

    def event_params
      params.require(:event).permit(:name, :description, :location, :event_date, :total_tickets)
    end
end
