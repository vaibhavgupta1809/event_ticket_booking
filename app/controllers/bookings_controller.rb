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
    ActiveRecord::Base.transaction do
      event = Event.lock.find(booking_params[:event_id])
      raise ActiveRecord::RecordNotFound unless event
      @booking = event.bookings.build(user: current_user, ticket_quantity: booking_params[:ticket_quantity].to_i)
  
      # Build tickets for the booking
      @booking.ticket_quantity.times do
        @booking.tickets.build(event_id: event.id)
      end

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
