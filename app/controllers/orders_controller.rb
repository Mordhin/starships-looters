class OrdersController < ApplicationController
  def create
    booking = Booking.find(params[:booking_id])
    order = Order.create!(booking: booking, amount: booking.total_amount, state: 'To pay', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: booking.ship.name,
        # images: [booking.ship.photo_url],
        amount: booking.price_cents,
        currency: 'eur',
        quantity: 1
      }],
      success_url: bookings_url,
      cancel_url: bookings_url
    )

    order.update(checkout_session_id: session.id)
    redirect_to new_order_payment_path(order)
  end

  def show
    @order = current_user.orders.find(params[:id])
  end
end
