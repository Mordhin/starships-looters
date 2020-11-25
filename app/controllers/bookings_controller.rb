class BookingsController < ApplicationController
  before_action :find_ship, only: %i[new create destroy]
  before_action :find_booking, only: %i[destroy validate]

  def index
    @bookings = Booking.all
    # Replace by scope when pundit
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(set_params)
    @booking.ship = @ship
    @booking.user = current_user

    if @booking.save
      redirect_to bookings_path, notice: 'Your booking has been created'
    else
      render :new
    end
  end

  def destroy
    redirect_to ship_path(@ship), notice: 'Your booking had been deleted'
  end

  def validate
    @booking.status = 'validated'
    @booking.save
    redirect_to bookings_path
  end

  def decline
    @booking.status = 'cancelled'
    @booking.save
    redirect_to bookings_path
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def find_ship
    @ship = Ship.find(params[:ship_id])
  end

  def set_params
    params.require(:booking).permit(:date_start, :date_end, :crew_size)
  end
end
