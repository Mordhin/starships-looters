class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    #Replace by scope when pundit
  end
end
