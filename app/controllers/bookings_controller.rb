class BookingsController < ApplicationController
  def new
    @booking = Booking.new(event_id: params[:event_id])
  end

  def create
    ActiveRecord::Base.transaction do
      event = Event.lock.find(booking_params[:event_id])
      raise ActiveRecord::RecordNotFound unless event
      @booking = event.bookings.build(user: current_user, ticket_quantity: booking_params[:ticket_quantity].to_i)
  
      if @booking.save
        flash[:notice] = "Tickets successfully booked."
        redirect_to events_path
      else
        render :new
      end
    end
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Event not found."
    redirect_to events_path
  rescue ActiveRecord::LockingError
    flash[:alert] = "The ticket booking process is currently busy."
    redirect_to events_path
  end

  private
    def booking_params
      params.require(:booking).permit(:ticket_quantity, :event_id)
    end
end

