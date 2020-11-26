class BookingsController < ApplicationController
  before_action :find_ship, only: %i[new create destroy]
  before_action :find_booking, only: %i[decline validate]

  def index
    # work in progress lol
    @my_own_bookings = Booking.where("user_id = ?", current_user.id)
    my_ships_id = []
    current_user.ships.each do |ship|
      my_ships_id << ship.id
    end
    @my_ships_bookings = Booking.where(:ship_id => my_ships_id)

    # @bookings = Booking.all.order(:date_start)
    # Replace by scope when pundit
  end

  def new
    @booking = Booking.new
    date_range
  end

  def create
    @booking = Booking.new(set_params)
    @booking.ship = @ship
    @booking.user = current_user
    @booking.status = 'Pending'
    date_range = set_params[:date_start].split(' to ')
    @booking.date_start = date_range[0]
    @booking.date_end = date_range[1]
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
    @booking.status = 'Validated'
    @booking.save
    redirect_to bookings_path
  end

  def decline
    @booking.status = 'Cancelled'
    @booking.save
    redirect_to bookings_path
  end

  private

  def date_range

  end

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
