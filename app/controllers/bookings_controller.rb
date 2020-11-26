require 'date'

class BookingsController < ApplicationController
  before_action :find_ship, only: %i[new create destroy]
  before_action :find_booking, only: %i[decline validate]

  def index
    # Incoming rides
    @my_own_bookings = Booking.where("user_id = ?", current_user.id).order(:date_start)

    # My monkey business
    my_ships_id = []
    current_user.ships.each do |ship|
      my_ships_id << ship.id
    end
    @my_ships_bookings = Booking.where(:ship_id => my_ships_id).order(:date_start)

    # Past rides and monkey business


    # @bookings = Booking.all.order(:date_start)
    # Replace by scope when pundit
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(set_params)
    update_booking
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
    save_redirect
  end

  def decline
    @booking.status = 'Cancelled'
    save_redirect
  end

  def cancel
    @booking.status = 'Cancelled'
    save_redirect
  end

  def pay
    @booking.status = 'Paid'
    save_redirect
  end

  def close
    @booking.status = 'Closed'
    save_redirect
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

  def update_booking
    @booking.ship = @ship
    @booking.user = current_user
    @booking.status = 'Pending'
    date_range = set_params[:date_start].split(' to ')
    @booking.date_start = Date.parse(date_range[0])
    @booking.date_end = Date.parse(date_range[1])
    @booking.total_amount = ((Date.parse(date_range[1]) - Date.parse(date_range[0])) * @ship.price_per_day.to_i).to_i
  end

  def save_redirect
    @booking.save
    redirect_to bookings_path, notice: "Your booking is now #{@booking.status}."
  end
end
