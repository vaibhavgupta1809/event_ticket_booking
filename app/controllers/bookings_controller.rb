class BookingsController < ApplicationController
  before_action :set_booking, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

 
  def index
    @bookings = Booking.all
  end

  def show
  end

  
  def new
    @booking = Booking.new(event_id: params[:event_id])
  end

  def edit
  end

  def create
    Event.transaction do
      event = Event.find(booking_params[:event_id])
      raise ActiveRecord::RecordNotFound unless event

      total_booked_tickets = event.bookings.sum(:ticket_quantity)
      requested_tickets = booking_params[:ticket_quantity].to_i

      if (event.total_tickets - total_booked_tickets) >= requested_tickets
        booking = event.bookings.build(user: current_user, ticket_quantity: requested_tickets)
        if booking.save
          flash[:notice] = "Tickets successfully booked."
          redirect_to events_path
        else
          flash[:alert] = booking.errors.full_messages.to_sentence
          redirect_to events_path
        end
      else
        flash[:alert] = "Not enough tickets available."
        redirect_to events_path
      end
    end
  rescue ActiveRecord::StaleObjectError
    flash[:alert] = "The ticket availability has changed. Please try again."
    redirect_to events_path
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to my_events_and_bookings_path, notice: "Booking was successfully updated." }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @booking.destroy

    respond_to do |format|
      format.html { redirect_to bookings_url, notice: "Booking was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:ticket_quantity, :event_id)
    end
end
