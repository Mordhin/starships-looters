class BookingsController < ApplicationController
  before_action :find_ship, only: %i[new create]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(set_params)
    @user = @ship.user
    @booking.ship = @ship
    @booking.user = @user

    if @booking.save
      redirect_to bookings_path, notice: 'Your Booking has been created'
    else
      render :new
    end

  end

  private

  def find_ship
    @ship = Ship.find(params[:ship_id])
  end

  def set_params
    params.require(:bookings).permit(:date_start, :date_end, :crew_size)
  end
end
