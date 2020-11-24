class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @ship = Ship.find(params[:ship_id])
  end

  def create
    @booking = Booking.new(set_bookings)
    @ship = Ship.find(params[:ship_id])

    @owner = @ship.user
    @booking.ship = @ship
    @booking.user = @owner

    if @booking.save
      redirect_to bookings_path, notice: 'Your request has been created'
    else
      render :new
    end
  end

  private

  def set_bookings
    params.require(:bookings).permit(:crew_size, :date_start, :date_end)
  end
end
