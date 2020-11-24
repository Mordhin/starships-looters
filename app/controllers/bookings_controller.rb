class BookingsController < ApplicationController
  before_action :find_ship, only: %i[new create destroy]

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(set_params)
    @user = @ship.user
    @booking.ship = @ship
    @booking.user = current_user

    if @booking.save
      redirect_to bookings_path, notice: 'Your booking has been created'
    else
      render :new
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    redirect_to ship_path(@ship), notice: 'Your booking had been deleted'
  end

  private

  def find_ship
    @ship = Ship.find(params[:ship_id])
  end

  def set_params
    params.require(:bookings).permit(:date_start, :date_end, :crew_size)
  end
end
