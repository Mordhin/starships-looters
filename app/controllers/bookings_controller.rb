require 'date'

class BookingsController < ApplicationController
  before_action :find_ship, only: %i[new create destroy]
  before_action :find_booking, only: %i[edit update decline validate cancel pay close]

  def index
    # Incoming rides
    @my_own_bookings = Booking.where(user_id: current_user.id).where.not(status: ['cancelled', 'closed']).order(:date_start)

    # My monkey business
    my_ships_id = []
    current_user.ships.each do |ship|
      my_ships_id << ship.id
    end
    @my_ships_bookings = Booking.where(:ship_id => my_ships_id).where.not(status: ['cancelled', 'closed']).order(:date_start)

    @all_my_past_bookings = Booking.where(:status => ['cancelled', 'closed'], user_id: current_user.id).or(Booking.where(:status => ['cancelled', 'closed'], :ship_id => my_ships_id))
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

  def edit
    @ship = Ship.find(@booking.ship_id)
  end

  def update
    @ship = Ship.find(@booking.ship_id)
    price_before = ActiveSupport::NumberHelper::number_to_delimited(@booking.total_amount, delimiter: '.')
    update_booking
    if @booking.save
      price_after = ActiveSupport::NumberHelper::number_to_delimited(@booking.total_amount, delimiter: '.')
      redirect_to bookings_path, notice: "Your booking #{@booking.id} has been edited. #{price_before} 👾 ➡ #{price_after} 👾"
    else
      render :edit
    end
  end

  def destroy
    redirect_to ship_path(@ship), notice: 'Your booking has been deleted'
  end

  def validate
    @booking.status = 'validated'
    save_redirect
  end

  def decline
    # increment cancel_qty
    @booking.status = 'cancelled'
    save_redirect
  end

  def cancel
    # @booking.ship.user.cancel_qty += 1 if @booking.ship.user_id == current_user.id
    # current_user.penalty_amount = @booking.total_amount / 10
    # current_user.penalty_owner_id = @booking.ship.user_id if @booking.user_id == current_user.id && @booking.status = 'validated'
    @booking.status = 'cancelled'
    save_redirect
  end

  def pay
    @booking.status = 'paid'
    save_redirect
  end

  def close
    @booking.status = 'closed'
    save_redirect
  end

  def pay_penalty
    # current_user.penalty_amount = 0
    # current_user.penalty_owner_id = nil
  end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def find_ship
    @ship = Ship.find(params[:ship_id])
  end

  def set_params
    # add :penalty_amount, :penalty_user_id
    params.require(:booking).permit(:date_start, :date_end, :crew_size)
  end

  def update_booking
    @booking.ship = @ship
    @booking.user = current_user
    @booking.status = 'pending'
    @booking.crew_size = set_params[:crew_size]
    date_range = set_params[:date_start].split(' to ')
    @booking.date_start = Date.parse(date_range[0])
    if date_range[1].nil?
      @booking.date_end = @booking.date_start
      @booking.total_amount = @ship.price_per_day.to_i
    else
    @booking.date_end = Date.parse(date_range[1])
    @booking.total_amount = ((Date.parse(date_range[1]) - Date.parse(date_range[0]) + 1) * @ship.price_per_day.to_i).to_i
    end
  end

  def save_redirect
    @booking.save
    redirect_to bookings_path, notice: "Your booking is now #{@booking.status}."
  end
end
