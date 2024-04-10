class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: [:index]
  

  def index
    @events = Rails.cache.fetch("events/all", expires_in: 1.hours) do
      Event.all.to_a
    end
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user

    if @event.save
      Rails.cache.delete('events/all')
      redirect_to events_path, notice: "Event was successfully created." 
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @event.update(event_params)
      Rails.cache.delete('events/all')
      redirect_to events_path, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity 
    end
  end

  def destroy
    if @event.destroy
      Rails.cache.delete('events/all')
      redirect_to events_url, notice: "Event was successfully destroyed."
    else
      redirect_to events_url, alert: "Failed to destroy event."
    end
  end

  def user_event_and_bookings
    @bookings = current_user.bookings
    @my_events = Event.where(user: current_user)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :description, :location, :event_date, :total_tickets)
    end
end
