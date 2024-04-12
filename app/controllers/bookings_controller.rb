class BookingsController < ApplicationController 
  before_action :set_event, only: %i[ new create ]

  def new
    @booking = @event.bookings.new
  end

  def create
    begin
      ticket_quantity = booking_params[:ticket_quantity].to_i
      @booking = @event.bookings.build(user: current_user, ticket_quantity: ticket_quantity)
      if ticket_quantity > 0
        ActiveRecord::Base.transaction do
          if @event.available_tickets >= ticket_quantity
            begin
              @event.available_tickets -= ticket_quantity
              @event.save!
              
              if @booking.save
                Rails.cache.delete('events/all')
                flash[:notice] = "Tickets successfully booked."
                redirect_to my_events_and_bookings_path
              else
                render :new, status: :unprocessable_entity
              end
            rescue ActiveRecord::StaleObjectError => e
              flash[:notice] = "Failed to book tickets due to a simultaneous booking attempt."
              redirect_to events_path
            end
          else
            flash[:alert] = "Not enough tickets available."
            redirect_to events_path
          end
        end
      else
        flash[:alert] = "Invalid ticket quantity."
        render :new, status: :unprocessable_entity
      end
    end
  end

  private
    def booking_params
      params.require(:booking).permit(:ticket_quantity)
    end

    def set_event
      @event = Event.find_by(id: params[:event_id])
      unless @event
        redirect_to events_url, notice: "Event not found."
      end
    end
end

